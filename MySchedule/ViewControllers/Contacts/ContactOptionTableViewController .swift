//
//  ContactOptionTableViewController .swift
//  MySchedule
//
//  Created by Maksim  on 11.06.2022.
//

import UIKit

class ContactOptionTableViewController: UITableViewController {
    
    private let idOptionsContactCell = "idOptionsContactCell"
    private let idOptionsContactCellHeader = "idOptionsContactCellHeader"
    
    private  let headerNameArray = ["NAME","PHONE","MAIL","TYPE","CHOOSE IMAGE"]
    
    private let cellNameArray = [
        "Name", "Phone", "Mail", "Type", ""
     ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        
        title = "Optional Schedule"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    // Определяем количество ячеек в секциях таблице: В нулевой секции будет 2 ячейки!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactCellHeader)
    }
    // 3.2 Отображаем наши данные в ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactConfigure(nameArray: cellNameArray, index: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    //4.1 Отображаем названия заголовок в Функции по созданию секции
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactCellHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    // Функция по выполнению действии после нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
       
    }
    
   private func pushControllers(vc: UIViewController, title: String) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = title
        navigationController?.pushViewController(viewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    
}

