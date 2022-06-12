//
//  Schedule.swift
//  MySchedule
//
//  Created by Maksim  on 11.06.2022.
//

import RealmSwift
import Foundation

class Schedule: Object {
    
    @Persisted var scheduleDate = Date()
    @Persisted var scheduleTime = Date()
    @Persisted var scheduleName: String = ""
    @Persisted var scheduleType: String = ""
    @Persisted var scheduleBuilding: String = ""
    @Persisted var scheduleAudience: String = ""
    @Persisted var scheduleTeacher: String = "Name Last"
    @Persisted var scheduleColor: String = "3DACF7"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
    
}
