//
//  ToDoItem.swift
//
//  Handles representation of a To-do item. 
// A to-do item is simply a string of text and a Boolean that indicates whether the item is completed or not.
//
//  Created by Evan Dorn on 10/25/15.
//
//
//

import UIKit

class ToDoItem: NSObject {
    
    // Text description of the item
    var text: String
    
    // A Boolean Value that determines the completed state of the item
    var completed: Bool
    
    // Initializer: Returns a ToDoItem initialized with the given text and default completed value
    init(text: String) {
        self.text = text
        self.completed = false
    }
    
    
}
