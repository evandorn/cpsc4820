//
//  CoursesViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/26/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // var coursesCount = 0
    var context: NSManagedObjectContext!
    var totalEntries: Int = 0

    @IBOutlet weak var courseTableView: UITableView!
    override func viewDidLoad() {
        // set the context and then load the data from core data
        context = appDelegate.managedObjectContext!
        loadCoursesFromCoreData()
        // println(appDelegate.courseArray.count)
      
        
    }
   
   
    // this is the function called when the user clicks save in the add course view controller
    // This function will handle adding the course to the core data
    @IBAction func unwindFromAddCourseViewController(unwindSegue: UIStoryboardSegue)
    {
      
        let addCourseView: AddCoursesViewController = unwindSegue.sourceViewController as! AddCoursesViewController
        let weekCharArray: [Character] = addCourseView.whichDaysOfWeekAreSelected()
        let errorPointer = NSErrorPointer()
        
        let courseEntity = NSEntityDescription.entityForName("Course", inManagedObjectContext: context)
        
        // attempt to add the course to our core data
        var newCourse: Course = Course(entity: courseEntity!, insertIntoManagedObjectContext: context)
        newCourse.id = totalEntries
        println("The course id is \(totalEntries)")
    
        newCourse.name = addCourseView.courseName.text
        newCourse.courseDescription = addCourseView.courseDescription.text
        newCourse.creditHours = addCourseView.creditHours.text.toInt()!
        newCourse.teacher = addCourseView.teacherID
        println("The teacher id is \(addCourseView.teacherID)")
        newCourse.location = addCourseView.courseLocation.text
        newCourse.startTime = addCourseView.startTimeDate
        newCourse.endTime = addCourseView.endTimeDate
        newCourse.daysOfWeek = String(weekCharArray)
        
        // attempt to save the newly created core data object
        context.save(errorPointer)
        if(errorPointer != nil)
        {
            println("There was an error saving the course to the core data")
            println(errorPointer.debugDescription)
            println(errorPointer.memory?.localizedFailureReason)
        }
        else
        {
            // the save was successful
            // reload the core data model and table view to show the changes
            println("The course was succesfully added to core data")
            self.loadCoursesFromCoreData()
        }
    }
    // This is the function that counts the number of items in the core data model
    // It also reloads the table view
    func loadCoursesFromCoreData()
    {
     
        let request = NSFetchRequest(entityName: "Course")
        // dont forget to be bug free
        request.returnsObjectsAsFaults = false
        totalEntries = context.countForFetchRequest(request, error: nil) // do any error handling
        println("number of courses \(totalEntries)")
        courseTableView.delegate = self
        courseTableView.dataSource = self
        courseTableView.reloadData()
     
    }
    // How to create a show segue programatically (show the info view)
    @IBAction func infoView(sender: AnyObject) {
        let infoView: infoViewController = storyboard?.instantiateViewControllerWithIdentifier("infoViewController") as! infoViewController
        self.showViewController(infoView, sender: self)
    }
    
    // always allow the segue's from this view controller
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return true
    }
    // Table view delegate & dataSource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEntries
    }
    // This function will be the segue to the assignments view controller
    // if the user has selected a course in the table we should then go to the assignment view for that course
    // We also need to send any information that we have to the assignment view (we can do this in the other view controller but I am doing this before becuase I still have my reference to indexPath.row)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let assigmentView: AssignmentViewController = storyboard?.instantiateViewControllerWithIdentifier("AssignmentViewController") as! AssignmentViewController
        
        let request = NSFetchRequest(entityName: "Course")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        
        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
     
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        var startString = dateFormatter.stringFromDate((results[indexPath.row] as! Course).startTime)
        // println(startString)
        dateFormatter.dateFormat = "hh:mm a"

        var endString = dateFormatter.stringFromDate((results[indexPath.row] as! Course).endTime)
        // println(endString)
        
        // set up the next view
        assigmentView.teacherID = Int((results[indexPath.row] as! Course).teacher)
        assigmentView.timeOfDayString = "\(startString) - \(endString)"
        assigmentView.daysOfWeekString = (results[indexPath.row] as! Course).daysOfWeek
        assigmentView.courseID = Int((results[indexPath.row] as! Course).id)
        // finally show the view controller
        self.showViewController(assigmentView, sender: self)
    }
    
    // 1 column table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // this function is used to obtain the teacher name in core data. Because the teacher name is not stored in the course data model 
    // we need to use a function to get the teacher name (the name is used in the table view cell (cellForRowAtIndexPath))
    func fetchTeacherName(idNumber: Int) -> String
    {
        var teacherName: String = ""
        let request = NSFetchRequest(entityName: "Teacher")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        
        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
       
           teacherName = (results[idNumber] as! Teacher).name
        
        return teacherName
    }
    // This is the function to set up my data in the table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CourseCell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! CourseCell
        
        let request = NSFetchRequest(entityName: "Course")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        // println(totalEntries)
        
        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
        //println(results.count)
     
            // using the array I have set the coursename, location and teacher name (using my helper function)
            cell.courseName?.text = (results[indexPath.row] as! Course).name
            
            cell.locationName?.text = (results[indexPath.row] as! Course).location
            // println(Int((results[indexPath.row] as! Course).teacher))
            cell.teacherName?.text = fetchTeacherName(Int((results[indexPath.row] as! Course).teacher))
          
        
     
        
        return cell
    }
    
}
// custom UITableViewCell class
// will be used to give the cell a custom look
class CourseCell: UITableViewCell
{
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var locationName: UILabel!
    
}