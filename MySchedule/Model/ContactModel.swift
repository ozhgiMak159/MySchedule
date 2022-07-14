//
//  ContactModel.swift
//  MySchedule
//
//  Created by Maksim  on 15.06.2022.
//

import RealmSwift
import Foundation

class ContactModel: Object {
    @Persisted var contactName = "Unknown"
    @Persisted var contactPhone = "Unknown"
    @Persisted var contactMail = "Unknown"
    @Persisted var contactType = "Unknown"
    @Persisted var contactImage: Data?
}
