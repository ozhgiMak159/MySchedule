//
//  AlertOK.swift
//  MySchedule
//
//  Created by Maksim  on 12.06.2022.
//

import UIKit

extension UIViewController {
    
    func alertOK(titel: String, message: String?) {
        let alert = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)

        present(alert, animated: true)
    }
    
    
}
