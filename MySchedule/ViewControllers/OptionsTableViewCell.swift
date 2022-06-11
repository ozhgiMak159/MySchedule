//
//  OptionsTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
//    private let addImageContact: UIImageView = {
//       let imageView = UIImageView()
//        imageView.layer.cornerRadius = 10
//        imageView.image = UIImage(systemName: "person.fill.badge.plus")
//        imageView.isHidden = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 3.1 Используем массив с данными для ячеек и иницилизируем свойства внутри ячейки
    func cellScheduleConfigure(nameArray: [[String]], index: IndexPath) {
        nameCellLabel.text = nameArray[index.section][index.row]
        
        if index == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
        // ?
        if index == [4,0] {
            repeatSwitch.isHidden = false
        }
    }
    
    func cellContactConfigure(nameArray: [String], index: IndexPath) {
        nameCellLabel.text = nameArray[index.section]
        
        index.section == 4
        ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus")
        : nil
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        
    }
    
}

// MARK: - Set Constraints
extension OptionsTableViewCell {
    
    private func addSubview() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        selectionStyle = .none
        
        addSubview(backgroundViewCell)
        addSubview(nameCellLabel)
        contentView.addSubview(repeatSwitch)
       // contentView.addSubview(addImageContact)
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
        
//        NSLayoutConstraint.activate([
//            addImageContact.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            addImageContact.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            addImageContact.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            addImageContact.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
//        ])
  
    }
}

