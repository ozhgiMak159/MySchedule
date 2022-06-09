//
//  OptionsScheduleCell.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

class OptionsScheduleCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameCellLabel: UILabel = {
       let label = UILabel()
        label.text = "12345"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
}

// MARK: - Set Constraints
extension OptionsScheduleCell {
    
    private func addSubview() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        selectionStyle = .none
        
        addSubview(backgroundViewCell)
        addSubview(nameCellLabel)
       
    }
    
    
    private func setConstraints() {
       
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15)
        ])
  
    }
}

