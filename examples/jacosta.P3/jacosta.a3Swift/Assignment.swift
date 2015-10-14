//
//  Assignment.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/28/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation


class Assignment
{
    let id: Int64
    let name: String
    let description: String
    let dueDate: NSDate
    let course: Int64
    
    
    
    init(newID: Int64, newName: String, newDesc: String, newDate: NSDate, newCourse: Int64)
    {
        id = newID
        name = newName
        description = newDesc
        dueDate = newDate
        course = newCourse
    }
    
    init()
    {
        id = 0
        name = ""
        description = ""
        dueDate = NSDate()
        course = 0
    }
}