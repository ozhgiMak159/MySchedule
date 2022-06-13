//
//  TaskModel.swift
//  MySchedule
//
//  Created by Maksim  on 13.06.2022.
//

import Foundation
import RealmSwift

class TaskModel: Object {
    
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescription: String = "Unknown"
    @Persisted var taskColor: String = "1A4766"
    @Persisted var taskReady: Bool = false

}
