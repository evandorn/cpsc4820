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
    
    var totalEntries: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        runHistroyTableView?.reloadData()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Run")
        request.returnsObjectsAsFaults = false
        
        totalEntries = context!.countForFetchRequest(request, error: nil)
        
        print("Number of Entries:  ")
        print(totalEntries)
        
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
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Run")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context!.executeFetchRequest(request, error: nil)!
        
        //Get contents and put into cel'
        var runHistory = results[indexPath.row] as! Run
        
        var distanceString = (String)(_cocoaString: runHistory.distance)
        var timeString = (String)(_cocoaString: runHistory.timestamp)
        var durationString = (String)(_cocoaString: runHistory.duration)
        
        cell.detailTextLabel!.text = "Distance: " + distanceString + " " + "Duration: " + durationString + " " + "Date: " + timeString
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
        
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //delete obj from entity and remove from list
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Run")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context!.executeFetchRequest(request, error: nil)!
        
        context!.deleteObject(results[indexPath.row] as! NSManagedObject)
        context!.save(nil)
        totalEntries = totalEntries - 1
        
        runHistroyTableView.reloadData()
    }
}
