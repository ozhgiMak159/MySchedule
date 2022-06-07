//
//  ScheduleTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 07.06.2022.
//

import UIKit

// Закончил на 4 уроке 27.12

class ScheduleTableViewCell: UITableViewCell {
    
    private let lessonName: UILabel = {
        let label = UILabel()
        label.text = "Swift lesson"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    
    private let teacherName: UILabel = {
        let label = UILabel()
        label.text = "Martiens.V"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    
    var stackView = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        stackView = UIStackView(arrangedSubviews: [lessonName,teacherName],
                                axis: .horizontal,
                                distribution: .fillEqually,
                                spacing: 10)

        addSubview(stackView)
    }
    
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
}
