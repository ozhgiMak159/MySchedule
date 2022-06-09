//
//  AlertDate.swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import UIKit

extension UIViewController {
    
    func alertDate(label: UILabel, completionHandler: @escaping (Int, Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        
        // Действия которые происходят после нажатия на кнопку ОК
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            /*
             После нажатия на кнопку Ок мы должны передать нашим лейблам в ячейках значения - Даты.
             1. Создаем форматеры дат.
             2. Определяем текущию местоположения
             3. В замыкании передаем - номер дня недели и саму дату выбранного дня
             4. Передаем данные выбранного дня/месца/года в текущий лейбл в ячейки
             */
            
            //1
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            //2
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekday], from: datePicker.date)
            guard let weekDay = components.weekday else { return }
            let numberWeekDay = weekDay
            let date = datePicker.date as Date
            // 3
            completionHandler(numberWeekDay,date)
            // 4
            label.text = dateString
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true

        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        present(alert, animated: true)
    }
}

