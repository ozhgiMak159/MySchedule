//
//  ColorTableViewCell.swift
//  MySchedule
//
//  Created by Maksim  on 10.06.2022.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 3.1 Используем массив с данными для ячеек и иницилизируем свойства внутри ячейки
    // ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    func cellConfigure(index: IndexPath) {
        switch index.section {
        case 0: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case 1: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case 2: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case 3: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case 4: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case 5: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        case 6: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        default:
            break
        }
    }
}

// MARK: - Set Constraints
extension ColorTableViewCell {
    
    private func addSubview() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        selectionStyle = .none
        
        addSubview(backgroundViewCell)
    }
    
    private func setConstraints() {
       
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
}


