//
//  HomeViewController.swift
//  RunTracker
//
//  Created by Evan Dorn on 9/19/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
  var managedObjectContext: NSManagedObjectContext?

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.destinationViewController.isKindOfClass(NewRunViewController) {
      if let newRunViewController = segue.destinationViewController as? NewRunViewController {
        newRunViewController.managedObjectContext = managedObjectContext
      }
    }
  }
}
