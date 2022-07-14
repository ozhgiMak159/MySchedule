//
//  ScheduleOptionsTableViewController.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

class ScheduleOptionsTableViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsScheduleCellHeader = "idOptionsScheduleCellHeader"
    
    private let headerNameArray = ["DATE AND TIME","LESSON","TEACHER","COLOR","PERIOD"]
    
    var cellNameArray = [
         ["Date","Time"],
         ["Name","Type","Building","Audience"],
         ["Teacher Name"],
         [""],
         ["Repeat every 7 days"]
     ]
    
    var scheduleModel = ScheduleModel()
    
    var hexColorCell = "3DACF7"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Optional Schedule"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
     
        setDelegate()
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped))
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleCellHeader)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, index: indexPath, hexColor: hexColorCell)
        cell.switchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleCellHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLabel) { numberWeekday, date in
                self.scheduleModel.scheduleDate = date
                self.scheduleModel.scheduleWeekday = numberWeekday
        }
        case [0,1]:
            alertTime(label: cell.nameCellLabel) { time in
                self.scheduleModel.scheduleTime = time
        }
        case [1,0]:
            alertForCellInformation(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson") { name in
                self.scheduleModel.scheduleName = name
        }
        case [1,1]:
            alertForCellInformation(label: cell.nameCellLabel, name: "Type lesson", placeholder: "Enter type lesson") { type in
                self.scheduleModel.scheduleType = type
        }
        case [1,2]:
            alertForCellInformation(label: cell.nameCellLabel, name: "Building number", placeholder: "Enter number of building") { building in
                self.scheduleModel.scheduleBuilding = building
        }
        case [1,3]:
            alertForCellInformation(label: cell.nameCellLabel, name: "Audience number", placeholder: "Enter number of audience") { audience in
                self.scheduleModel.scheduleAudience = audience
        }
        case [2,0]:
            pushControllers(vc: TeachersTableViewController(), title: "Options")
        case [3,0]:
            pushControllers(vc: ScheduleColorVC(), title: "Options")
        default:
            break
        }
    }
    
   private func pushControllers(vc: UIViewController, title: String) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = title
        navigationController?.pushViewController(viewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func saveButtonTapped() {
        
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleTime == nil || scheduleModel.scheduleName == "Unknown" {
            alertOK(titel: "Error", message: "Required fields: DATE, TIME, NAME")
        } else {
            scheduleModel.scheduleColor = hexColorCell
            StorageManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            navigationController?.popViewController(animated: true)
            tableView.reloadData()
        }
    }
    
}

extension ScheduleOptionsTableViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        scheduleModel.scheduleRepeat = value
    }
}

