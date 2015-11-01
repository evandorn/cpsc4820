//
//  LoginViewController.swift
//  RunTracker
//
//  Created by Evan Dorn on 10/9/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    /*
    var name: UITextField?
    
    let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //User name and password
        name = UITextField(frame: CGRect(x:(self.view.frame.width/2)-100 , y: (self.view.frame.height/2)-50, width: 200.00, height: 40.00))
        name?.backgroundColor = UIColor.blackColor()
        name?.borderStyle = UITextBorderStyle.Line
        name?.placeholder = "Name"
        self.view.addSubview(name!)
        
        //adding login button
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake((self.view.frame.width/2)-50, (self.view.frame.height/2)+70, 100, 40)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Start", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    // Vova helped with linking the 2K button to the next view
    func buttonAction(sender: UIButton) {
        
        println("Go pressed")
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        let ent = NSEntityDescription.entityForName("User", inManagedObjectContext: context)
        
        //Instance of custom class, reference to entity
        var newUser = User(entity: ent!, insertIntoManagedObjectContext: context)
        newUser.username = self.name!.text
        context.save(nil)
        println(newUser)
        performSegueWithIdentifier("tab_segue", sender: nil)
        
    }
*/ 
}
