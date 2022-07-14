//
//  StorageManager.swift
//  MySchedule
//
//  Created by Maksim  on 11.06.2022.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    private let realm = try! Realm()
    
    private init() {}
    
    // MARK: - ScheduleModel
    func saveScheduleModel(model: ScheduleModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func delete(model: ScheduleModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    // MARK: - TaskModel
    func saveTaskModel(model: TaskModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteTask(model: TaskModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: TaskModel, bool: Bool) {
        try! realm.write({
            task.taskReady = bool
        })
    }
    
    // MARK: - ContactModel
    func deleteContact(model: ContactModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func saveContactModel(model: ContactModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func updateContactModel(model: ContactModel, nameArray: [String], imageData: Data?) {
        try! realm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactMail = nameArray[2]
            model.contactType = nameArray[3]
            model.contactImage = imageData
        } 
    }
    
}
