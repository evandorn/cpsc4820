//
//  Course.swift
//  
//
//  Created by Joey Costa on 9/28/15.
//
//

import Foundation
import CoreData

class CourseCore: NSManagedObject {

    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var courseDescription: String
    @NSManaged var creditHours: Int64
    @NSManaged var location: String
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    @NSManaged var daysOfWeek: String
    @NSManaged var teacher: Int64

}
