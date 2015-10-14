//
//  AddCoursesViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/26/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// This is example code to create extensions on an object (such as UIColor)
// All this is doing is creating new UIColors
// To use these, we can now simply use them like any other UIColor
// startButton.backgroundColor = UIColor.blueColor()
// startButton.backgroundColor = UIColor.segmentControllerBlue()

extension UIColor{
    static func segmentControllerBlue() -> UIColor
    {
        return UIColor(red: 96, green: 96, blue: 96, alpha: 1)
    }
    static func veryPaleGrayColor() -> UIColor{
        return UIColor(red: 192, green: 192, blue: 192, alpha: 1)
    }
}

class AddCoursesViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //  var teacherCount = 0
    var context: NSManagedObjectContext!
    var totalEntries: Int = 0
    var teacherID: Int = 0
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var viewWithinScrollView: UIView!
    
    @IBOutlet weak var startTime: UILabel!
    var startTimeDate: NSDate!
    
    @IBOutlet weak var endTime: UILabel!
    var endTimeDate: NSDate!
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var nameOfCourse: UILabel!
    
    @IBOutlet weak var courseDescription: UITextView!
    
    @IBOutlet weak var descriptionOfCourse: UILabel!
    @IBOutlet weak var creditHours: UITextField!
    
    @IBOutlet weak var creditHoursLabel: UILabel!
    @IBOutlet weak var courseLocation: UITextField!
    @IBOutlet weak var courseLocationLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var monday: UIButton!
    @IBOutlet weak var tuesday: UIButton!
    @IBOutlet weak var wednesday: UIButton!
    @IBOutlet weak var thursday: UIButton!
    @IBOutlet weak var friday: UIButton!
    
    @IBOutlet weak var teacherTable: UITableView!
    @IBOutlet weak var teacherLabel: UILabel!
    
     override func viewDidLoad() {
        // set up the view ( colors of the buttons )
        setColorOfDaysOfWeek()
        // set the context and load the data from core data
        context = appDelegate.managedObjectContext!
        loadTeacherCoreData()
    }
    // this function is to set the color of the buttons in the view to the custom UIColors
  func setColorOfDaysOfWeek()
  {
    monday.backgroundColor = .veryPaleGrayColor()
    monday.titleLabel?.textColor = UIColor.blackColor()
    
    tuesday.backgroundColor = .veryPaleGrayColor()
    tuesday.titleLabel?.textColor = UIColor.blackColor()
    
    wednesday.backgroundColor = .veryPaleGrayColor()
    wednesday.titleLabel?.textColor = UIColor.blackColor()
    
    thursday.backgroundColor = .veryPaleGrayColor()
    thursday.titleLabel?.textColor = UIColor.blackColor()
    
    friday.backgroundColor = .veryPaleGrayColor()
    friday.titleLabel?.textColor = UIColor.blackColor()
 
    
    
    }
    // This function is to change the color of the day buttons
    // the buttons (monday, tuesday, wednesday, thursday and friday) are linked up to this function
    // when the user clicks a button based on its current selected status, we will change the background color and the text color
    @IBAction func selectedDay(sender: UIButton)
    {
        if(sender.selected)
        {
            // println("not selected")
        sender.backgroundColor = UIColor.segmentControllerBlue()
            sender.titleLabel?.textColor = UIColor.whiteColor()
            sender.selected = false
        }
        else
        {
            //println("selected")
            sender.backgroundColor = .veryPaleGrayColor()
            sender.titleLabel?.textColor = UIColor.blackColor()
            sender.selected = true
            
        }
        
    }
    
    @IBAction func saveCourse(sender: AnyObject) {
        
        
    }
    // this is the function that stops the user from saving a course if one or more of the fields are empty
    //
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "unwindAddCourse")
        {
            var emptyCount: Int = 0
            var daysOfWeekStringError: String = ""
           if(courseName.text.isEmpty)
           {
            println("The course name is empty")
            emptyCount++
            nameOfCourse.textColor = .redColor()
            }
            else
           {
            nameOfCourse.textColor = .blackColor()
            }
            if(courseDescription.text.isEmpty)
            {
                println("The course description is empty")
            emptyCount++
                descriptionOfCourse.textColor = .redColor()
            }
            else
            {
              descriptionOfCourse.textColor = .blackColor()
            }
            
            if(creditHours.text.isEmpty)
            {
                println("The credit hours field is empty")
                emptyCount++
                creditHoursLabel.textColor = .redColor()
            }
            else
            {
                creditHoursLabel.textColor = .blackColor()
            }
            
            if(courseLocation.text.isEmpty)
            {
                println("The course location is empty")
                emptyCount++
            courseLocationLabel.textColor = .redColor()
            }
            else
            {
                courseLocationLabel.textColor = .blackColor()
            }
            if(startTime.text! == " ")
            {
                println("The start time is empty")
                emptyCount++
                startTimeLabel.textColor = .redColor()
            }
            else
            {
                startTimeLabel.textColor = .blackColor()
            }
            if(endTime.text! == " ")
            {
                println("The end time is empty")
                emptyCount++
                endTimeLabel.textColor = .redColor()
            }
            else{
               endTimeLabel.textColor = .blackColor()
            }
            let weekString: [Character] = whichDaysOfWeekAreSelected()

                if(weekString.isEmpty)
                {
                    println("No days of the week are selected")
                    daysOfWeekStringError = "No days of the week are selected"
                    emptyCount++
                }
                else{
                    
            }
            
            if(teacherTable.indexPathForSelectedRow()?.row == nil)
            {
              println("No teacher selected in table")
                teacherLabel.textColor = .redColor()
            }
            else{
                teacherLabel.textColor = .blackColor()
            }
            if(emptyCount == 0)
            {
                return true
            }
            else{
                let alert: UIAlertController = UIAlertController(title: "Empty Fields", message: "The fields with red titles have not been set. Cannot save course. \(daysOfWeekStringError)", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
                    action in
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            
        }
        /// always allow the user to select a time
        if(identifier == "SelectTime")
        {
            return true
        }
        // always allow the user to add a new teacher
        if(identifier == "GoToAddTeacherViewController")
        {
            return true
        }
     return false
    }
    // This function creates an array of characters that will be what we will use to know which days of the week were selected
    func whichDaysOfWeekAreSelected() -> Array<Character>
    {
        var weekString = Array<Character>()
        if(monday.selected)
        {
            println("monday Selected")
            weekString.append("M")
        }
        if(tuesday.selected)
        {
            println("tuesday selected")
            weekString.append("T")
        }
        if(wednesday.selected)
        {
         println("wednesday selected")
            weekString.append("W")
        }
        if(thursday.selected)
        {
            println("thursday selected")
            weekString.append("H")
        }
        if(friday.selected)
        {
            println("friday selected")
            weekString.append("F")
        }
        return weekString
    }
    // load all of the teachers from core data. 
    // find out how many teachers are in core data and then reload the table view with the new data
    func loadTeacherCoreData()
    {
        let request = NSFetchRequest(entityName: "Teacher")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        totalEntries = context.countForFetchRequest(request, error: nil)
      
        self.teacherTable.delegate = self
        self.teacherTable.dataSource = self
        self.teacherTable.reloadData()
    }
    // this function will allow me to change the style of the segue for both adding a teacher and selecting a time
    // We will be using a popover presentation style to show these view controllers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "GoToAddTeacherViewController")
        {
            let popoverViewController = segue.destinationViewController as! AddTeacherViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
        }
        // send to the selectTimeViewController which button was hit 
        // was it the start or end time hit, and depending on which one we should set the time appropriately
        if(segue.identifier == "SelectTime")
        {
            let popoverViewController = segue.destinationViewController as! SelectTimeViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            if(sender?.tag == 1)
            {
                // start time set hit
                popoverViewController.whichButton = .Start
            }
            if(sender?.tag == 2)
            {
                // end time set hit
                popoverViewController.whichButton = .End
            }
            popoverViewController.preferredContentSize = CGSize(width: 200, height: 300)
            popoverViewController.popoverPresentationController!.delegate = self
            
        }
        
    }
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    @IBAction func unwindFromAddTeacherViewController(unwindSegue: UIStoryboardSegue)
    {
        loadTeacherCoreData()
        let addTeacherView: AddTeacherViewController = unwindSegue.sourceViewController as! AddTeacherViewController
        let errorPointer =  NSErrorPointer()
        // add the teacher that was created to the internal database and then show it in the table
      
        // attempt to add the teacher to the core data model
        let teacherEntity = NSEntityDescription.entityForName("Teacher", inManagedObjectContext: context)
        var newTeacher: Teacher = Teacher(entity: teacherEntity!, insertIntoManagedObjectContext: context)
         println("The teacher id is \(totalEntries)")
        newTeacher.id = totalEntries
        newTeacher.name = addTeacherView.teacherName.text!
        newTeacher.username = addTeacherView.teacherUsername.text!
        newTeacher.officeLocation = addTeacherView.teacherOffice.text!
        /*
        if(addTeacherView.teacherPhoneNumber.text.isEmpty)
        {
            newTeacher.phoneNumber := 411
        }
        else
        {
        newTeacher.phoneNumber = Int64(addTeacherView.teacherPhoneNumber.text.toInt()!)
        }
*/
        context.save(errorPointer)
        
        if(errorPointer != nil)
        {
           println("There was an error saving the teacher to the core data")
            println(errorPointer.debugDescription)
            println(errorPointer.memory?.localizedFailureReason)
        }
        else
        {
            println("The teacher was succesfully added to core data")
        self.dismissViewControllerAnimated(true, completion: nil)
            self.loadTeacherCoreData()
        }
        // println("called")
    }
    // this is the function that helps set the time when the user clicks set in selecttime view controller
    
    @IBAction func unwindFromSelectTimeViewController(unwindSegue: UIStoryboardSegue)
    {
        let selectTimeView: SelectTimeViewController = unwindSegue.sourceViewController as! SelectTimeViewController
        //println(selectTimeView.datePicker.date)
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        var strDate = dateFormatter.stringFromDate(selectTimeView.datePicker.date)
        //println(strDate)
        
        // check to see if the user hit the start button or the end button
        // then set the corresponding time
        if(selectTimeView.whichButton == StartorEndButton.Start)
        {
           startTime.text = strDate
            startTimeDate = selectTimeView.datePicker.date
        }
        else
        {
           endTime.text = strDate
            endTimeDate = selectTimeView.datePicker.date
        }
        // finally dismiss the view controller (becuase it is a popover )
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // set the number of items in the table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEntries
    }
    // (debugging purposes)
    // Selecting the row in the table view simply sets the teacherID (used in creating a course) to the id of the teacher
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let request = NSFetchRequest(entityName: "Teacher")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        
        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        teacherID = Int((results[indexPath.row] as! Teacher).id)
        

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // function to describe a cell in the table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("teacherCell", forIndexPath: indexPath) as! UITableViewCell
        
        let request = NSFetchRequest(entityName: "Teacher")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false

        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
        // set the teacher name and email of the table view cell
            let teacher: Teacher = results[indexPath.row] as! Teacher
          cell.textLabel?.text = teacher.name
            cell.detailTextLabel?.text = "\(teacher.username)@clemson.edu"
        
       
        return cell
    }
  

    
}