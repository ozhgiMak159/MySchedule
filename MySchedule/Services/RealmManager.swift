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
    let realm = try! Realm()
    
    func saveScheduleModel(model: Schedule) {
        try! realm.write {
            realm.add(model)
        }
    }
    

    private init() {}
}
