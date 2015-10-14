//
//  User.swift
//  RunTracker
//
//  Created by Evan Dorn on 10/6/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    
    @NSManaged var id: NSNumber
    @NSManaged var username: NSString
}
