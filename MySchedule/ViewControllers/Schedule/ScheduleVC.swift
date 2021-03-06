//
//  ScheduleVC.swift
//  MySchedule
//
//  Created by Maksim  on 06.06.2022.
//


import UIKit
import FSCalendar
import RealmSwift

class ScheduleViewController: UIViewController {
    
    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scope = .week
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private let showHideButton: UIButton = {
       let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var calendarHeightConstraint: NSLayoutConstraint!
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    private let optionTabCell = OptionsTableViewCell()
    
    private let identifierCell = "Cell"
    
    private let localRealm = try! Realm()
    private var scheduleArray: Results<ScheduleModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setConstrains()
        setDelegate()
        swipeAction()
        scheduleOnDay(date: Date())
        
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: identifierCell)
    }
    
    private func setDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    
    private func scheduleOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        //print(weekday)
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "scheduleWeekday = \(weekday) AND scheduleRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "scheduleRepeat = false AND scheduleDate BETWEEN %@",[dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(compound).sorted(byKeyPath: "scheduleTime")
        tableView.reloadData()
    }
    
    private func dateOrTimeFormatter(_ strintg: String, _ model: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = strintg
        return timeFormatter.string(from: model)
    }
    
    private func setColors(color: String) -> String {
        let optionalSchedule = ScheduleOptionsTableViewController()
        var colorNew = optionalSchedule.hexColorCell
        colorNew = color
        return colorNew
    }
    
    private func editingModel(model: ScheduleModel) {
        
        let optionalSchedule = ScheduleOptionsTableViewController()
      //  var swits = OptionsTableViewCell()
        guard let time = model.scheduleTime, let date = model.scheduleDate else { return }
        
        let dateTime = dateOrTimeFormatter("HH:mm", time)
        let dateDay = dateOrTimeFormatter("dd.MM.yyyy", date)
        
//        var color = UIColor().colorFromHex("\(model.scheduleColor)")
//        color = optionTabCell.backgroundColor!
        
        // optionalSchedule.scheduleModel = model
        optionalSchedule.cellNameArray = [
            ["\(dateDay)", "\(dateTime)"],
            [model.scheduleName, model.scheduleType, model.scheduleBuilding, model.scheduleAudience],
            [model.scheduleTeacher],
            [""],
            ["\(model.scheduleRepeat)"]
        ]
        
        navigationController?.pushViewController(optionalSchedule, animated: true)
        
        
        /*
         private func setColor(color: String) {
             let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
             scheduleOptions?.hexColorCell = color
             scheduleOptions?.tableView.reloadData()
             self.navigationController?.popViewController(animated: true)
         }
         */
        
        
        
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        default:
            showHideButtonTapped()
        }
    }
    
    @objc private func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
    }
  
    @objc private func addButtonTapped() {
        let scheduleOption = ScheduleOptionsTableViewController()
        navigationController?.pushViewController(scheduleOption, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - FSCalendarDelegate
extension ScheduleViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
}

// MARK: - FSCalendarDataSource
extension ScheduleViewController: FSCalendarDataSource {
 
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
     scheduleOnDay(date: date)
    }
}

// MARK: - UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = scheduleArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            StorageManager.shared.delete(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! ScheduleTableViewCell
        let content = scheduleArray[indexPath.row]
        cell.configure(model: content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = scheduleArray[indexPath.row]
        editingModel(model: model)
    }
}
// MARK: - ScheduleViewController & Set Constraints
extension ScheduleViewController {
    
    private func addSubView() {
        view.backgroundColor = .white
        title = "Schedule"
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped))
        
        view.addSubview(calendar)
        view.addSubview(showHideButton)
        view.addSubview(tableView)
        
        calendarHeightConstraint = NSLayoutConstraint(
        item: calendar, attribute: .height, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
    
    }
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


/*
 1 ??????
 private var contactArray: Results<ContactModel>!
 
 
 
 2 ??????
 private func editingModel(contactModel: ContactModel) {
     let contactOption = OptionContactTableViewController()
     contactOption.contactModel = contactModel
     contactOption.editModel = true
     contactOption.cellNameArray = [
         contactModel.contactName,
         contactModel.contactPhone,
         contactModel.contactMail,
         contactModel.contactType,
         ""
     ]
 
    navigationController?.pushViewController(contactOption, animated: true)
 
 
 3 ??????
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let model = contactArray[indexPath.row]
     editingModel(contactModel: model)
}
 */
