//
//  HeaderOptionsScheduleTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

class HeaderOptionsScheduleTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "", font: .avenirNext14())
    
    let headerNameArray = ["DATE AND TIME","LESSON","TEACHER","COLOR","PERIOD"]
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(section: Int) {
        headerLabel.text = headerNameArray[section]
    }
    
    
}

// MARK: - Set Constraints
extension HeaderOptionsScheduleTableViewCell {
    
    private func addSubview() {
        contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        headerLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        addSubview(headerLabel)
       
    }
    
    
    private func setConstraints() {
       
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

  
    }
}


