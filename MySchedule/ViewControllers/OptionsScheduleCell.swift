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
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch: UISwitch = {
       let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        repeatSwitch.addTarget(self, action: #selector(switchChange), for: .valueChanged)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    let cellNameArray = [
        ["Date","Time"],
        ["Name","Type","Building","Audience"],
        ["Teacher Name"],
        [""],
        ["Repeat every 7 days"]
    ]
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(index: IndexPath) {
        nameCellLabel.text = cellNameArray[index.section][index.row]
        
        if index == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
        
        if index == [4,0] {
            repeatSwitch.isHidden = false
        }
        
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        
    }
    
}

// MARK: - Set Constraints
extension OptionsScheduleCell {
    
    private func addSubview() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        selectionStyle = .none
        
        addSubview(backgroundViewCell)
        addSubview(nameCellLabel)
        contentView.addSubview(repeatSwitch)
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
        
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)
        ])
  
    }
}

