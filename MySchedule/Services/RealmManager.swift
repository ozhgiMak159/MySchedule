//
//  RealmManager.swift
//  MySchedule
//
//  Created by Maksim  on 11.06.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private let realm = try! Realm()
    
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
    
    // TaskModel
    func saveTaskModel(model: TaskModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    // Дженерик????
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

    private init() {}
}
