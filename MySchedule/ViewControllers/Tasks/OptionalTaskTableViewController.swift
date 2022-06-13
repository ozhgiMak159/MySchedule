//
//  OptionalTaskTableViewController.swift
//  MySchedule
//
//  Created by Maksim  on 10.06.2022.
//

import UIKit

class OptionalTaskTableViewController: UITableViewController {
    
    private let idOptionsTaskCell = "idOptionsTaskCell"
    private let idOptionsTaskHeader = "idOptionsTaskHeader"
    
    private  let headerNameArray = ["DATE","LESSON","TASK","COLOR"]
    private let cellNameArray = ["Date", "Lesson", "Task", ""]
    
    var hexColorCell = "1A4766"
    
    private var taskModel = TaskModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        
        title = "Optional Tasks"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    // Определяем количество ячеек в секциях таблице: В нулевой секции будет 2 ячейки!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTaskHeader)
    }
    // 3.2 Отображаем наши данные в ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTaskCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, index: indexPath, hexColor: hexColorCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    //4.1 Отображаем названия заголовок в Функции по созданию секции
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTaskHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    // Функция по выполнению действии после нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { _, date in
            self.taskModel.taskDate = date
        }
        case 1: alertForCellInformation(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson") { name in
            self.taskModel.taskName = name
        }
        case 2: alertForCellInformation(label: cell.nameCellLabel, name: "Description Task", placeholder: "Enter Description task") { task in
            self.taskModel.taskDescription = task
        }
        case 3: pushControllers(vc: TaskColorTableVC(), title: "Optional Task")
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
        
        if taskModel.taskDate == nil || taskModel.taskName == "Unknown" {
            alertOK(titel: "Error", message: "Required fields: DATE, TIME, NAME")
        } else {
            taskModel.taskColor = hexColorCell
            RealmManager.shared.saveTaskModel(model: taskModel)
            // Если приложения крашится при повторном изменении
            taskModel = TaskModel()
            alertOK(titel: "Данные успешно сохранены", message: nil)
            // Обновления ячееек после сохранения
            hexColorCell = "1A4766"
            tableView.reloadData()
        }
    }

}
