//
//  TasksTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 08.06.2022.
//

import UIKit

// Закончил 5 на 16:00


class TasksTableViewCell: UITableViewCell {
    
    private let taskName = UILabel(text: "SwiftUI", font: .avenirNextDemiBold16())
    private let taskDescription = UILabel(text: "Основы языка SwiftUI", font: .avenirNext14())
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func readyButtonTapped() {
        print("12")
    }
    
}

// MARK: - Set Constraints
extension TasksTableViewCell {
    
    private func addSubview() {
        
        addSubview(taskName)
        addSubview(taskDescription)
        contentView.addSubview(readyButton)
        
        //???
        taskDescription.numberOfLines = 2
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}

