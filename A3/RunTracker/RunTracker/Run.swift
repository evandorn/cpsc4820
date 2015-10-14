//
//  Run.swift
//  RunTracker
//
//  Created by Evan Dorn on 9/19/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import CoreData

class Run: NSManagedObject {

    @NSManaged var id: Int64
    @NSManaged var duration: NSNumber
    @NSManaged var distance: NSNumber
    @NSManaged var timestamp: NSDate
    @NSManaged var locations: NSOrderedSet
}
