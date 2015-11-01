//
//  RunHistoryTableViewController.swift
//  RunTracker
//
//  Created by Evan Dorn on 9/24/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RunHistoryTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var runHistroyTableView: UITableView!
    var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
    var context: NSManagedObjectContext!

    var totalEntries: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        runHistroyTableView?.reloadData()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Run")
        request.returnsObjectsAsFaults = false
        
        totalEntries = context!.countForFetchRequest(request, error: nil)
        println("Number of entries: \(totalEntries)")
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEntries
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HistoryCell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! HistoryCell

        let myRequest = NSFetchRequest(entityName: "Run")
        myRequest.returnsObjectsAsFaults = false
        
        println("Inside Table View")
        
        let results: NSArray = context.executeFetchRequest(myRequest, error: nil)!
        
        println("After results View")
        // Get contents and put into cell
        println("Label printing")

        cell.durationLabel?.text = "Duration: \((results[indexPath.row] as! Run).duration)"
        cell.distanceLabel?.text = "Distance: \((results[indexPath.row] as! Run).distance)"
        //cell.timestampLabel?.text = "Time Stamp: \((results[indexPath.row] as! Run).timestamp)"
        cell.timestampLabel?.text = "Time Stamp: "

        
        /*
        var distanceString = (String)(_cocoaString: runHistory.distance)
        var timeString = (String)(_cocoaString: runHistory.timestamp)
        var durationString = (String)(_cocoaString: runHistory.duration)
        */
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
        
    }
    /*
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //delete obj from entity and remove from list
    
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        var request = NSFetchRequest(entityName: "Run")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context!.executeFetchRequest(request, error: nil)!
        
        context!.deleteObject(results[indexPath.row] as! NSManagedObject)
        context!.save(nil)
        totalEntries = totalEntries - 1
        
        runHistroyTableView.reloadData()
    }
*/

} 
