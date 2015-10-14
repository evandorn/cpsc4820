//
//  Course.swift
//  
//
//  Created by Joey Costa on 9/28/15.
//
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var courseDescription: String
    @NSManaged var creditHours: NSNumber
    @NSManaged var location: String
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    @NSManaged var daysOfWeek: String
    @NSManaged var teacher: NSNumber

}
