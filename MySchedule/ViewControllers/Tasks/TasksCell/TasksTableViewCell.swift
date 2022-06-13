//
//  TasksTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 08.06.2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    private let taskName = UILabel(text: "", font: .avenirNextDemiBold16())
    private let taskDescription = UILabel(text: "", font: .avenirNext14())
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //  Создаем экземпляр протокола для доступа к методу
    weak var cellTaskDelegate: PressReadyTaskButtonProtocol?
    var indexPath: IndexPath?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TaskModel) {
        taskName.text = model.taskName
        taskDescription.text = model.taskDescription
        backgroundColor = UIColor().colorFromHex("\(model.taskColor)")
        
        if model.taskReady {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    // 2 Говорим что наша кнопка выполняет действия
    @objc private func readyButtonTapped() {
        guard let indexPath = indexPath else { return }
        cellTaskDelegate?.readyButtonTapped(indexPath: indexPath)
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

