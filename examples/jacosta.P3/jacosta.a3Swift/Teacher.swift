//
//  Teacher.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/28/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation

class Teacher {
    
    let id: NSNumber
    let name: String
    let username: String
    let officeLocation: String
     let phoneNumber: NSNumber
    
    init(newID: Int, newName: String, newUsername: String, newOffice: String, newPhoneNumber: NSNumber)
    {
        id = newID
        name = newName
        username = newUsername
        officeLocation = newOffice
        phoneNumber = newPhoneNumber
    }
    
    init()
    {
        id = 0
        name = ""
        username = ""
        officeLocation = ""
        phoneNumber = 0
    }
}