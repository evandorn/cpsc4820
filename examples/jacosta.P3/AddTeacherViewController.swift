//
//  AddTeacherViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/26/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit

class AddTeacherViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var teacherName: UITextField!
    @IBOutlet weak var teacherNameLabel: UILabel!
    
    @IBOutlet weak var teacherUsername: UITextField!
    @IBOutlet weak var teacherUsernameLabel: UILabel!
    @IBOutlet weak var teacherOffice: UITextField!
    @IBOutlet weak var teacherOfficeLabel: UILabel!
    @IBOutlet weak var teacherPhoneNumber: UITextField!
    @IBOutlet weak var saveTeacher: UIButton!
    
    
    // This function will stop the unwind segue if the fields in the add Teacher view are empty!
    // if the fields are not empty then the user should be allowed to save the teacher
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        if(identifier == "unwindAddTeacher")
        {
            var countEmptyTexts: Int = 0
            if(teacherName.text.isEmpty)
            {
                println("Teachers name is empty")
                countEmptyTexts++
                teacherNameLabel.textColor = .redColor()
            }
            else
            {
                teacherNameLabel.textColor = .blackColor()
            }
            if(teacherUsername.text.isEmpty)
            {
                println("Teacher username is empty")
                countEmptyTexts++
                teacherUsernameLabel.textColor = .redColor()
            }
            else
            {
                teacherUsernameLabel.textColor = .blackColor()
            }
            if(teacherOffice.text.isEmpty)
            {
                println("Teacher office is empty")
                countEmptyTexts++
                teacherOfficeLabel.textColor = .redColor()
            }
            else
            {
                teacherOfficeLabel.textColor = .blackColor()
            }
            if(teacherPhoneNumber.text.isEmpty)
            {
                
            }
            if(countEmptyTexts != 0)
            {
                let alert: UIAlertController = UIAlertController(title: "Empty Fields", message: "One or more of the required fields are empty. Please enter information in the required fields.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    action in
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}