//
//  Teacher.swift
//  
//
//  Created by Joey Costa on 9/28/15.
//
//

import Foundation
import CoreData

class TeacherCore: NSManagedObject {

    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var officeLocation: String
    // @NSManaged var phoneNumber: Int64

}
