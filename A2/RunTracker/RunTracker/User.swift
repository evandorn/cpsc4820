//
//  User.swift
//  RunTracker
//
//  Created by Evan Dorn on 10/2/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    
    @NSManaged var username: String
    @NSManaged var id: NSNumber
    
}
