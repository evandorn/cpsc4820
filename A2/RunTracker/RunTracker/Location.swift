//
//  Location.swift
//  RunTracker
//
//  Created by Evan Dorn on 9/19/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {

    @NSManaged var timestamp: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var run: NSManagedObject

}
