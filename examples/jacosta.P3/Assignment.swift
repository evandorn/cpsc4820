//
//  Assignment.swift
//  
//
//  Created by Joey Costa on 9/28/15.
//
//

import Foundation
import CoreData

class Assignment: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var assignmentDesc: String
    @NSManaged var dueDate: NSDate
    @NSManaged var course: NSNumber

}
