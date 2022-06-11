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
    @Persisted var scheduleTeacher: String = ""
    @Persisted var scheduleColor: String = ""
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
    
}
