//
//  Teacher.swift
//  
//
//  Created by Joey Costa on 9/28/15.
//
//

import Foundation
import CoreData

class Teacher: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var officeLocation: String

}
