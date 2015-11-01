//
//  LoginViewController.swift
//  RunTracker
//
//  Created by Evan Dorn on 10/9/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(sender: AnyObject) {
        
        var user_key: NSNumber = 0
        
        managedObjectContext = appDel.managedObjectContext!
        let ent = NSEntityDescription.entityForName("User", inManagedObjectContext:
            managedObjectContext!)
        
        //Instance of custom class, reference to entity
        var newUser = User(entity: ent!, insertIntoManagedObjectContext: managedObjectContext)
        newUser.username = self.textField!.text
        managedObjectContext!.save(nil)
        println(newUser)
        
        performSegueWithIdentifier("login_segue", sender: nil)
    }
}
