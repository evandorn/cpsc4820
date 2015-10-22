//
//  User.swift
//  Tarea
//
//  Created by Evan Dorn on 10/22/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    
    @NSManaged var historyid: String
    @NSManaged var mytaskid: String
    @NSManaged var password: String
    @NSManaged var username: String
}
