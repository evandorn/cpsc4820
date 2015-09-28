//
//  AboutViewController.swift
//  RunTracker
//
//  Created by Evan Dorn on 9/23/15.
//  Copyright (c) 2015 Evan Dorn. All rights reserved.
//

import Foundation

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var AboutNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }
}
