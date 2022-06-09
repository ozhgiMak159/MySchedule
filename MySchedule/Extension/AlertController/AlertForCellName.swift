//
//  AlertForCellName.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

extension UIViewController {
    
    func alertForCellInformation(label: UILabel, name: String, placeholder: String) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let textFieldAlert = alert.textFields?.first
            guard let text = textFieldAlert?.text else { return }
            label.text = text
        }
        
        alert.addTextField { (alerTF) in
            alerTF.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
}
