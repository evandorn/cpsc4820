//
//  SelectTimeViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/28/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit
enum StartorEndButton
{
    case Start
    case End
}

class SelectTimeViewController: UIViewController {
    
    // This is a very simple view controller, most of my code to handle what time is selected is in the Add course view controller
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDate: UIButton!
    var whichButton: StartorEndButton!
    /// var dateLabel: NSDate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // (debugging purposes)
        // simply print which button was hit to arrive at this view controller
        // did the user hit set start time or did the user hit set end time
        if(whichButton == .Start)
        {
            println("Start button")
        }
        else
        {
            println("End button")
        }
    }
    
    @IBAction func setDate(sender: AnyObject) {
      
    }
}