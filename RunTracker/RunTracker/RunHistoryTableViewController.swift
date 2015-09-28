//
//  RunHistoryTableViewController.swift
//  RunTracker
//
//  Created by Evan Dorn on 9/24/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
   
    let tableData = ["This table will contain run history in the next version."]
    var filteredTableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reload the table
        self.tableView.reloadData()
    }
}
