//
//  ScheduleVC.swift
//  MySchedule
//
//  Created by Maksim  on 06.06.2022.
//


import UIKit
import FSCalendar

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
    
    
    private let identifierCell = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setConstrains()
        setDelegate()
        swipeAction()
        
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
    //2 - 3
    @objc private func addButtonTapped() {
        let scheduleOption = OptionsScheduleTableViewController()
        navigationController?.pushViewController(scheduleOption, animated: true)
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
        print(date)
    }
}

// MARK: - UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}

// MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! ScheduleTableViewCell
        return cell
    }
    
    
}
// MARK: - ScheduleViewController Set Constraints
extension ScheduleViewController {
    
    private func addSubView() {
        view.backgroundColor = .white
        title = "Schedule"
        //2
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
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