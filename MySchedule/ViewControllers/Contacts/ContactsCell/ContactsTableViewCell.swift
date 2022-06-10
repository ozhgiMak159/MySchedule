//
//  ContactsTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 10.06.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    //  Создаем экземпляр протокола для доступа к методу
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 2 Говорим что наша кнопка выполняет действия
  
    
}

// MARK: - Set Constraints
extension ContactsTableViewCell {
    
    private func addSubview() {
  
    }
    
    private func setConstraints() {
        
    }
}
