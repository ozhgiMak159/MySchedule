//
//  ScheduleVC.swift
//  MySchedule
//
//  Created by Maksim  on 06.06.2022.
//


import UIKit
import FSCalendar


// Закончил на 3 видео - 9:10

class ScheduleViewController: UIViewController {
    
    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private var calendarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setConstrains()
    }
    
    private func setDelegate() {
        
    }
    
    
    
}
extension ScheduleViewController: FSCalendarDelegate {
 

}

extension ScheduleViewController: FSCalendarDataSource {
 

}





extension ScheduleViewController {
    
    private func addSubView() {
        view.backgroundColor = .white
        title = "Schedule"
        
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(
        item: calendar, attribute: .height, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
    
    }
    
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    
    }

}
