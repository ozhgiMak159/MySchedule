//
//  ContactsViewController.swift
//  MySchedule
//
//  Created by Maksim  on 06.06.2022.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.bounces = false
        return tableView
    }()
    
    private let segmentControl: UISegmentedControl = {
       let segment = UISegmentedControl(items: ["Friend", "Teachers"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    private var filteredArray: Results<ContactModel>!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let localReal = try! Realm()
    private var contactArray: Results<ContactModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setupSearch()
        setConstraints()
        
        title = "Contacts"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        contactArray = localReal.objects(ContactModel.self).filter("contactType = 'Friend'")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    private func setupSearch() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        searchController.searchResultsUpdater = self
    }
    
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
        
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
      
    @objc private func addButtonTapped() {
        let contactOptionTVC = OptionContactTableViewController()
        navigationController?.pushViewController(contactOptionTVC, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func segmentChanged() {
        if segmentControl.selectedSegmentIndex == 0 {
            contactArray = localReal.objects(ContactModel.self).filter("contactType = 'Friend'")
            tableView.reloadData()
        } else {
            contactArray = localReal.objects(ContactModel.self).filter("contactType = 'Teacher'")
            tableView.reloadData()
        }
    }
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredArray.count : contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        let content = isFiltering ? filteredArray[indexPath.row] : contactArray[indexPath.row]
        cell.configure(model: content)
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let model = contactArray[indexPath.row]
         editingModel(contactModel: model)
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContact(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredArray = contactArray.filter("contactName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
}

extension ContactsViewController {
    
    private func setConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [segmentControl, tableView], axis: .vertical, distribution: .equalSpacing, spacing: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        
    }
}
