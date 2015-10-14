//
//  AssignmentViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/27/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MessageUI

class AssignmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var totalAssignments: Int = 0
    var assignmentID: Int = 0
    var courseID: Int = 0
    @IBOutlet weak var assignmentTableView: UITableView!
    @IBOutlet weak var professorName: UILabel!
    @IBOutlet weak var TimeOfDay: UILabel!
    @IBOutlet weak var daysOfWeek: UILabel!
    @IBOutlet weak var officeLocation: UILabel!
    var timeOfDayString: String = ""
    var daysOfWeekString: String = ""
    var professorEmail: String = ""
    var teacherID: Int = -1
    var assignmentArray = [Assignment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.managedObjectContext!
        println("The value of courseID = \(courseID)")
        loadAssignmentsFromCoreData()
        if(teacherID != -1)
        {
        fetchTeacherInfo(teacherID)
            TimeOfDay.text = timeOfDayString
            daysOfWeek.text = daysOfWeekString
        }
        else
        {
            println("Found no teacher?")
        }
        
    }
    
    /*
Email help from stack overflow
    http://stackoverflow.com/questions/28963514/sending-email-with-swift
    
*/
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([professorEmail])
        if(assignmentTableView.indexPathForSelectedRow()?.row != nil)
        {
            mailComposerVC.setSubject(assignmentTableView.cellForRowAtIndexPath(assignmentTableView.indexPathForSelectedRow()!)!.textLabel?.text)
        }
        else
        {
        mailComposerVC.setSubject("")
        }
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    // Send the add assignment view the number associated with the course. This is to help create the assignment
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let addAssignmentView: AddAssignmentViewController = segue.destinationViewController as! AddAssignmentViewController
        addAssignmentView.courseID = courseID
    }
    // Once the user has successfully entered all the fields for the assignment 
    // segue back to the assignment view, add the assignment to core data and finally reload the table
    @IBAction func unwindFromAddAssignmentViewController(unwindSegue: UIStoryboardSegue)
    {
              let addAssignmentView: AddAssignmentViewController = unwindSegue.sourceViewController as! AddAssignmentViewController
        let errorPointer = NSErrorPointer()
        let assignmentEntity = NSEntityDescription.entityForName("Assignment", inManagedObjectContext: context)
        var newAssignment: Assignment = Assignment(entity: assignmentEntity!, insertIntoManagedObjectContext: context)
        newAssignment.id = assignmentID
        println("The assignmentID was \(assignmentID)")
        newAssignment.name = addAssignmentView.assignmentName.text
        newAssignment.assignmentDesc = addAssignmentView.assignmentDescription.text
        newAssignment.dueDate = addAssignmentView.assignmentDueDate.date
        newAssignment.course = addAssignmentView.courseID
        println("The courseID of the assignment was \(courseID)")
        context.save(errorPointer)
        // handle any error if there was one
        if(errorPointer != nil)
        {
            println("There was an error saving the assignment to the core data")
            println(errorPointer.debugDescription)
            println(errorPointer.memory?.localizedFailureReason)
        }
        else
        {
            println("The assignemtn was succesfully added to core data")
            self.loadAssignmentsFromCoreData()
        }
    }
    // This is the function which counts the total number of assignments in the core data model. 
    // Because we dont want to view all the assignments (we only want to view assignments which are related to this course)
    // we need to only look at the assignments with a matching courseID
    func loadAssignmentsFromCoreData()
    {
        assignmentArray.removeAll(keepCapacity: false)
        let request = NSFetchRequest(entityName: "Assignment")
        // dont forget to be bug free
        request.returnsObjectsAsFaults = false
        // totalAssignments = context.countForFetchRequest(request, error: nil)
       
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
        assignmentID = results.count // keep a reference to the amount of assignments there were (this will be used to set the id)

        //    println(courseID)
        for(var i: Int = 0; i < results.count; i++)
        {
            // only add assignments with courseID matching the course you selected
            let assignmentCourseID: Int = Int(((results[i] as! Assignment).course))
            if(assignmentCourseID == courseID)
            {
                        println("The assignment course id is \(assignmentCourseID)")
assignmentArray.append((results[i] as! Assignment))
            }
        }
        // finally reload the table view
        totalAssignments = assignmentArray.count
        assignmentTableView.delegate = self
        assignmentTableView.dataSource = self
        assignmentTableView.reloadData()
        
        
    }
    // this function is used to set up the view at the top of the assignment view
    // We need to find the information about the teacher

    func fetchTeacherInfo(idNumber: Int)
    {
        var teacherName: String = ""
        let request = NSFetchRequest(entityName: "Teacher")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        // println(totalAssignments)
        // println(idNumber)
        
        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
        // retrieve the name,username, office of the professor
        teacherName = (results[idNumber] as! Teacher).name
        professorName.text = (results[idNumber] as! Teacher).name
        officeLocation.text = (results[idNumber] as! Teacher).officeLocation
        professorEmail = "\((results[idNumber] as! Teacher).username)@clemson.edu"
    }
    @IBAction func emailProfessor(sender: AnyObject) {
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalAssignments
    }
    // This function is not necessarry in the program, I am using it to simply print out the course number associated with the assignment
    // (helps debugging)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let request = NSFetchRequest(entityName: "Assignment")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
        
        
        let results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        let assignment: AnyObject = (results[indexPath.row])
        println((assignment as! Assignment).course)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("assignmentCell", forIndexPath: indexPath) as! UITableViewCell
        
        let request = NSFetchRequest(entityName: "Assignment")
        // dont forget to be bug free =)
        request.returnsObjectsAsFaults = false
     let results: NSArray = context.executeFetchRequest(request, error: nil)!
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd hh:mm a"
            var dateString = dateFormatter.stringFromDate(assignmentArray[indexPath.row].dueDate)
            // println(dateString)
            
            cell.textLabel?.text = (assignmentArray[indexPath.row].name)
            cell.detailTextLabel?.text = dateString
        
        return cell
    }
    //This function will allow us to remove entries from the core data model
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if the user has hit the delete button on the table view cell
        if(editingStyle == .Delete ) {
            let request = NSFetchRequest(entityName: "Assignment")
            // dont forget to be bug free =)
            request.returnsObjectsAsFaults = false
            let error = NSErrorPointer()
            let results: NSArray = context.executeFetchRequest(request, error: nil)!

            // Find the assignment number the user is trying to delete
             let assignmentNumber: Int = Int((assignmentArray[indexPath.row].id))
            let assignmentToDelete: AnyObject = (results[assignmentNumber]) // delete the assignment number not the assignment at the index path!!!
            // Delete it from the managedObjectContext then save it
             context.deleteObject(assignmentToDelete as! NSManagedObject)
            context.save(error)
          
            if(error != nil)
            {
                println("There was an error removing the assignment from the core data")
                println(error.debugDescription)
                println(error.memory?.localizedFailureReason)
            }
            else
            {
                // Since there was no error in removing the course, decrement the total assignments and remove the item from the table
                totalAssignments--
                println("The assigment was succesfully removed from core data")
                
            // Tell the table view to animate out that row
            assignmentTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            }
          
        }
    }
    
    
}