//
//  infoViewController.swift
//  jacosta.a3Swift
//
//  Created by Joey Costa on 9/29/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit
enum MyPhotos
{
    case primary
    case alternative
}

class infoViewController: UIViewController, UIGestureRecognizerDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    var displayedPhoto: MyPhotos = .primary
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("changeImage"))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        imageView.addGestureRecognizer(tapGesture)
        
    }
    
    func changeImage()
    {
        // Because the image is the primary image when the user taps the image the image should then be set to the alternative image.
        if(displayedPhoto == .primary)
        {
            imageView.image = UIImage(named: "MyPhoto2")
            displayedPhoto = .alternative
        }
            // If the imageView is displaying the alternative image, then on tap it should change back to the primary image.
        else
        {
            imageView.image = UIImage(named: "MyPhoto")
            displayedPhoto = .primary
        }
    }
}