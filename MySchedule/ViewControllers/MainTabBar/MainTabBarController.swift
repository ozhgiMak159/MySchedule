//
//  MainTabBarController.swift
//  MySchedule
//
//  Created by Maksim  on 06.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    /*
     Установка навигейшен контроллера и табБара
     */
    private func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        return navController
        
    }
    
    private func setupTabBar() {
        
        let scheduleVC = createNavController(vc: ScheduleViewController(), itemName: "Schedule", itemImage: "calendar.badge.clock")
        let tasksVC = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        let contactsVC = createNavController(vc: ContactsViewController(), itemName: "Contacts", itemImage: "rectangle.stack.person.crop")
        
        setViewControllers([scheduleVC, tasksVC, contactsVC], animated: true)
        
        UITabBarItem.appearance().titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Helvetica Neue", size: 14) as Any], for: .normal)
        
    }
    
}

