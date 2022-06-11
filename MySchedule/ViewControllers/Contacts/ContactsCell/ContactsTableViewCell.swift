//
//  ContactsTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 10.06.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    private let imageTeacher: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "jobs")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let phoneImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel = UILabel(text: "Stive Jods", font: .avenirNext16())
    private let phoneNumber = UILabel(text: "+7 555 66 77 88", font: .avenirNext14())
    private let mailLabel = UILabel(text: "StiveJods@mail.ru", font: .avenirNext14())
    
    private var stackView = UIStackView()
  
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        imageTeacher.layer.cornerRadius = imageTeacher.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Set Constraints
extension ContactsTableViewCell {
    
    private func addSubview() {
        addSubview(imageTeacher)
        addSubview(nameLabel)
        
        stackView = UIStackView(
            arrangedSubviews: [phoneImageView, phoneNumber, mailImageView, mailLabel],
            axis: .horizontal,
            distribution: .fillProportionally,
            spacing: 4
        )
        
        addSubview(stackView)
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            imageTeacher.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageTeacher.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageTeacher.widthAnchor.constraint(equalToConstant: 75),
            imageTeacher.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: imageTeacher.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
            stackView.leadingAnchor.constraint(equalTo: imageTeacher.trailingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
        
    }
}
