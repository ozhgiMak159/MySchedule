//
//  TaskColorTableVC.swift
//  MySchedule
//
//  Created by Maksim  on 10.06.2022.
//

import UIKit

class TaskColorTableVC: UITableViewController {
    
    private let idTaskColorCell = "idTaskColorCell"
    private let idTaskOptionsHeader = "idTaskOptionsHeader"
    
    private  let headerNameArray = ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        
        title = "Color Task"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    private func setColor(color: String) {
        let scheduleOptions = self.navigationController?.viewControllers[1] as? OptionalTaskTableViewController
        scheduleOptions?.hexColorCell = color
        scheduleOptions?.tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       1
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: idTaskColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idTaskOptionsHeader)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTaskColorCell, for: indexPath) as! ColorTableViewCell
        cell.cellConfigure(index: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idTaskOptionsHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            setColor(color: "BE2813")
        case 1:
            setColor(color: "EF5931")
        case 2:
            setColor(color: "F5B433")
        case 3:
            setColor(color: "467C24")
        case 4:
            setColor(color: "3DACF7")
        case 5:
            setColor(color: "3802DA")
        case 6:
            setColor(color: "8E5AF7")
        default:
            setColor(color: "FFFFFF")
        }
    }
}

