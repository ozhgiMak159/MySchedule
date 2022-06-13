//
//  ScheduleTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 07.06.2022.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    private let lessonName = UILabel(text: "", font: .avenirNext14())
    private let teacherName = UILabel(text: "", font: .avenirNext16())
    private let lessonTime = UILabel(text: "", font: .avenirNextDemiBold16())
    private let typeLabel = UILabel(text: "Тип:", font: .avenirNext14())
    private let lessonType = UILabel(text: "", font: .avenirNextDemiBold14())
    private let buildingLabel = UILabel(text: "Корпус:", font: .avenirNext14(), alignment: .right)
    private let lessonBuilding = UILabel(text: "", font: .avenirNextDemiBold14())
    private let auditoryLabel = UILabel(text: "Аудитория:", font: .avenirNext14(), alignment: .right)
    private let lessonAud = UILabel(text: "", font: .avenirNextDemiBold14())
    
    private var topStackView = UIStackView()
    private var buttonStackView = UIStackView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ScheduleModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        lessonName.text = model.scheduleName
        teacherName.text = model.scheduleTeacher
        guard let time = model.scheduleTime else { return }
        lessonTime.text = dateFormatter.string(from: time)
        lessonType.text = model.scheduleType
        lessonBuilding.text = model.scheduleBuilding
        lessonAud.text = model.scheduleAudience
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
    }
    
}

// MARK: - Set Constraints
extension ScheduleTableViewCell {
    
    private func addSubview() {
        selectionStyle = .none
        
        topStackView = UIStackView(arrangedSubviews: [lessonName,teacherName],
                                   axis: .horizontal,
                                   distribution: .fillEqually,
                                   spacing: 10)
        
        buttonStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, lessonBuilding, auditoryLabel, lessonAud],
                                      axis: .horizontal,
                                      distribution: .fillProportionally,
                                      spacing: 7)
        
        addSubview(topStackView)
        addSubview(lessonTime)
        addSubview(buttonStackView)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            buttonStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            buttonStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
}
