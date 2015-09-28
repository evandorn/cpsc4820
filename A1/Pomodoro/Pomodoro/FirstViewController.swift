//
//  FirstViewController.swift
//  Pomodoro
//
//  Created by Evan Dorn on 9/1/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import UIKit


enum startTimer {
    case WORK
    case BREAK
}

class FirstViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var displayTimeLabel: UILabel!
    @IBOutlet var workTimeTextBox: UITextField!
    @IBOutlet var breakTimeTextBox: UITextField!
    
    var startTime = NSTimeInterval()
    var targetTime :Int?
    var timer = NSTimer()
    var status :Int?
    
    var workString :String? = "25:00"
    var breakString :String? = "5:00"
    
    var workTime : Int? = 25*60
    var breakTime : Int? = 5*60
    
    var start : startTimer = .WORK
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        status = 0
        targetTime = workTime
    }
    
    
    func displayWorkTimeAlert() {
        let alert = UIAlertController(title: "All Done!", message: "Finished Work Timer!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okayAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayBreakTimeAlert() {
        let alert = UIAlertController(title: "All Done!", message: "Finished Break Timer!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okayAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displaySetWorkTimeAlert() {
        let alert = UIAlertController(title: "Set Break Time!", message: "New Work Time Set", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okayAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displaySetBreakTimeAlert() {
        let alert = UIAlertController(title: "Set Break Time", message: "New Break Time Set", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okayAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func timerNotStartedAlert() {
        
        let alert = UIAlertController(title: "Hey!", message: "Can't stop! You haven't started the timer yet!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okayAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func newWorkTimerValue() {
        workString = workTimeTextBox.text;
        workTime = workString?.toInt()
        workTime = workTime!*60
        workTimeTextBox.resignFirstResponder();
    }
    
   @IBAction func newBreakTimerValue() {
        breakString = breakTimeTextBox.text;
        breakTime = breakString?.toInt()
        breakTime = breakTime!*60
        breakTimeTextBox.resignFirstResponder();
    }
    
    // Start the timer
    @IBAction func start(sender: AnyObject) {
        newWorkTimerValue()
        newBreakTimerValue()
        
        println("start")
        timer.invalidate()
        if status == 0 {
            displayTimeLabel.text = workString
            targetTime = workTime
            start = .WORK
        }
        else if status == 1 {
            displayTimeLabel.text = breakString
            targetTime = breakTime
            start = .BREAK
        }
        println("\(displayTimeLabel.text)")
        timer.invalidate()
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }

    // stop the timer
    // With alerts for error checking
    @IBAction func stop(sender: AnyObject) {

        // Warning alert Can't stop if you haven't started
        if(displayTimeLabel.text == workString || displayTimeLabel.text == breakString) {
            let exitCode = 1
            timerNotStartedAlert()
            return
        }
                
        println("end")
        if status == 0 {
            println("end 25")
            status = 1
            displayTimeLabel.text = breakString
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var dateString = dateFormatter.stringFromDate(NSDate())
        } else {
            status = 0
            displayTimeLabel.text = workString
        }
        timer.invalidate()
    }
    
    func updateTime() {
        let endTime = NSDate.timeIntervalSinceReferenceDate()
        let time = Int(endTime-startTime)
        if time >= targetTime {
            if status == 0 {
                status = 1
                displayTimeLabel.text = breakString
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                var dateString = dateFormatter.stringFromDate(NSDate())
            } else {
                status = 0
                displayTimeLabel.text = workString
            }
            timer.invalidate()
        }
        let min = (targetTime!-time)/60 > 9 ? String((targetTime!-time)/60) : "0"+String((targetTime!-time)/60)
        let sec = (targetTime!-time)%60 > 9 ? String((targetTime!-time)%60) : "0"+String((targetTime!-time)%60)
        
        displayTimeLabel.text = "\(min):\(sec)"
        println("time=\(time) , count down=\(min):\(sec)")
        
        // Display an UIAlert for the when the work timer finishes
        if(displayTimeLabel.text == "00:00" && start == .WORK) {
            displayWorkTimeAlert()
        }
        
        // Display an UIAlert for the when the work timer finishes
        if(displayTimeLabel.text == "00:00" && start == .BREAK) {
            displayBreakTimeAlert()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
