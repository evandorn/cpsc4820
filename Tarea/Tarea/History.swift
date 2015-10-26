//
//  History.swift
//  Tarea
//
//  Created by Evan Dorn on 10/22/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import CoreData

class History: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var completed_task: String
}
