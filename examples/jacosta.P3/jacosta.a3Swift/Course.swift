//
//  Course.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/28/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation

class Course{
    let id: NSNumber
    let name: String
    let courseDescription: String
    let creditHours: NSNumber
    let location: String
    let startTime: NSDate
    let endTime: NSDate
    let daysOfWeek: String
    let teacher: NSNumber
    
    
    init(newID: NSNumber, newName: String, newDesc: String, newHours: NSNumber, newLocation: String, newStart: NSDate, newEnd: NSDate, newDays: String, newTeacher: NSNumber)
    {
        id = newID
        name = newName
        courseDescription = newDesc
        creditHours = newHours
        location = newLocation
        startTime = newStart
        endTime = newEnd
        daysOfWeek = newDays
        teacher = newTeacher
    }
    
    
    
    init()
    {
      id = 0
        name = ""
        courseDescription = ""
        creditHours = 0
        location = ""
        startTime = NSDate()
        endTime = NSDate()
        daysOfWeek = ""
        teacher = 0
        
    }
}