//
//  ContactsTableViewController.swift
//  MySchedule
//
//  Created by Maksim  on 06.06.2022.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setupSearch()
        
        title = "Contacts"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        
        tableView.separatorStyle = .singleLine
     //   tableView.bounces = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    private func setupSearch() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        13
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("123")
    }
    
    @objc private func addButtonTapped() {
        let contactOptionTVC = OptionContactTableViewController()
        navigationController?.pushViewController(contactOptionTVC, animated: true)
    }
    
}

