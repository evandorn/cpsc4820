//
//  AddAssignmentViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/27/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit

class AddAssignmentViewController: UIViewController {
    
    
    @IBOutlet weak var assignmentName: UITextField!
    
    @IBOutlet weak var assignmentDescription: UITextView!
    
    @IBOutlet weak var assignmentDueDate: UIDatePicker!
    var initialDate: NSDate!
    var courseID: Int = 0
    override func viewDidLoad() {
    super.viewDidLoad()
        // we will be using this trick to not allow the user to set the due date to the time it is now.
        initialDate = NSDate().dateByAddingTimeInterval(0)
        assignmentDueDate.date = initialDate
    }
    // Dont allow the user to save the assignment without entering the data in the fields
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
    if(identifier == "unwindAddAssignment")
        {
            var emptyCount: Int = 0
            var dueDateString: String = ""
            if(assignmentName.text.isEmpty)
                {
                   println("The assingment name is empty")
                    emptyCount++
            }
            if(assignmentDescription.text.isEmpty)
            {
                println("The assignment description is empty")
                emptyCount++
            }
            if(assignmentDueDate.date == initialDate){
                println("The assignment due date cant be set to now?")
                dueDateString = "The assigment due date cannot be set to the current time"
            emptyCount++
            }
            
            if(emptyCount == 0)
            {
                return true
            }
            else
            {
                let alert: UIAlertController = UIAlertController(title: "Empty Fields", message: "One or more of the required fields are empty. \(dueDateString)", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    action in
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        return false
    }
    
}