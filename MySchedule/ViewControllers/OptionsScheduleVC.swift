//
//  OptionsScheduleTableViewController.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

class OptionsScheduleTableViewController: UITableViewController {
    
    let idOptionsScheduleCell = "idOptionsScheduleCell"
    let idOptionsScheduleCellHeader = "idOptionsScheduleCellHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsScheduleCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsScheduleTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleCellHeader)
        
        title = "Optional"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsScheduleCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleCellHeader) as! HeaderOptionsScheduleTableViewCell
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    
}
