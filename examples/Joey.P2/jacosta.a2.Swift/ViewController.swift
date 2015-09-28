//
//  ViewController.swift
//  jacosta.a2.Swift
//
//  Created by Joey Costa on 9/14/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Darwin

class ViewController: UIViewController,CLLocationManagerDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, MKMapViewDelegate, UIAlertViewDelegate {

    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    var StateCapitalsArray: Array<StateCapitals>!
    var region: Int = 10000
    var capitalNumber: Int = 0
    var cLLocationManager: CLLocationManager!
    var usedCurrentLocation: Bool = false
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StateCapitalsArray = StateCapitals.allStateCapitals()
        textField.delegate = self
        self.capitalNumber = randomNumberBetweenZeroAndFifty()
        self.setUpCoordinates()

    }
    // Hide the text field  ( UITextFieldDelegate)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    /*
When the user has typed in a string this function will loop through all of the state capitals and their abbreviations and see if the user has typed in an existing state. Then it checks to see if the state matches the capital associated with it.
*/
    func checkArrayIfContains(text: String) -> Bool
    {
        var found: Bool = false
      
        
    
        for(var i = 0; i < StateCapitalsArray.count; i++)
        {
          if(((StateCapitalsArray[i].state.uppercaseString == text.uppercaseString || StateCapitalsArray[i].abbreviation.uppercaseString == text.uppercaseString)) && StateCapitalsArray[capitalNumber].capital == StateCapitalsArray[i].capital)
          {
            println("The string you typed \(text) matches a capital \(StateCapitalsArray[capitalNumber].state)")
            found = true
            }
        }
        if(found)
        
        {
            return true
        }

        
        return false
    }
    /* This is the function I will be using to determine whether or not
the text that was typed matched the state name or the abbreviation of the state
*/
    @IBAction func checkCapitalVsState(sender: AnyObject) {
        if(checkArrayIfContains(textField.text))
        {
            let alert = UIAlertController(title: "Correct", message: "You entered '\(textField.text)' \n The capital \(self.StateCapitalsArray[capitalNumber].capital) is from the state \(self.StateCapitalsArray[self.capitalNumber].state) (\(StateCapitalsArray[capitalNumber].abbreviation))", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Next", style: .Default, handler: {
                action in
                switch action.style{
                case .Default:
                    NSLog("Next")
                    self.capitalNumber = self.randomNumberBetweenZeroAndFifty()
                    self.setUpCoordinates()
                    self.textField.text = ""
                    self.resignFirstResponder()
                case .Cancel:
                    NSLog("Do something")
                case .Destructive:
                    NSLog("Do Something")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else
        {
            let alert = UIAlertController(title: "Incorrect", message: "The state you entered is not where this capital is from. Check your spelling.", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: {
                action in
                switch action.style{
                case .Default:
                    NSLog("Try Again")
                    self.textField.becomeFirstResponder()
                case .Cancel:
                    NSLog("Do something")
                case .Destructive:
                    NSLog("Do Something")
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Quit", style: .Default, handler: {
                
                action in
                switch action.style{
                case .Default:
                    NSLog("Quit")
                    self.resignFirstResponder()
                        self.dismissViewControllerAnimated(true, completion: nil)
                case .Cancel:
                    NSLog("Do something")
                case .Destructive:
                    NSLog("Do Something")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
 
    }
    
    /*
This function is dealing with the delegate CLLocationManagerDelegate
    When the app attempts to retrieve the user's location and an error occured this function is called
*/
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //NSLog("Location Not Recieved")
        println(error)
        let alert = UIAlertController(title: NSLocalizedString("Unable to Locate User", comment: "Unable to locate user title") , message: NSLocalizedString("Please enable location services to use this part of the application.", comment: "Enable location services notification"), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        NSLog("%@", error)
    }
    /*
This function has many purposes
    First purpose is to see what capital number the user (or the program) has chosen.
    If the capital is 0-49 then the program should show the user the location associated with capital number 0-49. If the capital number is equal to 51 (At first I had Clemson, SC in the list of capitals but later removed it) then the application should instead show the user where they are on the map.


*/
    func setUpCoordinates()
    {
        if(capitalNumber != 51)
        {
            if(usedCurrentLocation)
            {
            mapView.zoomEnabled = false
            mapView.rotateEnabled = false
            mapView.scrollEnabled = false
                usedCurrentLocation = false
                messageTextLabel.text = "Zooming and Scrolling have been disabled."
                self.animateMessageView()
            }
            println("The map has zoomed to \(StateCapitalsArray[capitalNumber].capital), \(StateCapitalsArray[capitalNumber].state) (\(StateCapitalsArray[capitalNumber].abbreviation))")
            let coordinate = CLLocationCoordinate2D(latitude: StateCapitalsArray[capitalNumber].latitude, longitude: StateCapitalsArray[capitalNumber].longitude)
            let region = MKCoordinateRegionMakeWithDistance(coordinate, CLLocationDistance(StateCapitalsArray[capitalNumber].region), CLLocationDistance(StateCapitalsArray[capitalNumber].region))
            self.mapView.setRegion(region, animated: true)
            var annotation = MKPointAnnotation()
            annotation.title = StateCapitalsArray[capitalNumber].capital
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
            
        }
        else // The user has selected their current location
        {
            println("Attempting to retrieve location")
            // 51 represents the current location
            // prepare user for using current location
            cLLocationManager = CLLocationManager()
            cLLocationManager.delegate = self
            mapView.delegate = self
            mapView.showsUserLocation = true
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            cLLocationManager.requestWhenInUseAuthorization()
            cLLocationManager.startUpdatingLocation()
            
            // Prompt the user to allow location services
            // based on what the user's settings are plan accordingly (the app need location to be set to "Always" or "WhenInUse"
            switch CLLocationManager.authorizationStatus() {
                
                
            case .NotDetermined:
                println("Not determined")
                cLLocationManager.requestWhenInUseAuthorization()
            case .Restricted, .Denied:
                println("Restricted, denied")
                let alertController = UIAlertController(
                    title: NSLocalizedString("Location Service Request Denied", comment: "Location services denied title"),
                    message: NSLocalizedString("In order to use this app, please open this app's settings and set location access to 'Always'.", comment: "Location Service denied message"),
                    preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                    if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }
                alertController.addAction(openAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            case .AuthorizedWhenInUse, .AuthorizedAlways:
                println("Allowed")
                
               
                
            }
          
        }
    }
    /*
Here is example of animation code a UIView.transitionWithView
    And we are setting the animation let transitionOptions = UIViewAnimationOptions.TransistionFlipFlopTop
    
    What this code is doing is creating animations within animations (3 to be exact)
    The first one will transition up with a curl and then show the message view
    The second one will pause the third animation by 3 seconds (notice how the code is in the completion of the second animation)
    The third UIView.transitionWithView will hide the view by transitionFlipFromTop. 
    
    Overall this function will show a view (that contains a label on it) and present it to the user and automatically dismiss the view after 3 seconds has passed
    
*/
    func animateMessageView()
    {
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromTop
        UIView.transitionWithView(self.messageView, duration: 1.0, options: transitionOptions, animations: {
            self.messageView.hidden = false
            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
                
                let transitionOptions = UIViewAnimationOptions.TransitionCrossDissolve
                
                UIView.transitionWithView(self.messageView, duration: 3.0, options: transitionOptions, animations: {
                    
                    }, completion: { finished in
                        // any code entered here will be applied
                        // once the animation has completed
                        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromTop
                        
                        UIView.transitionWithView(self.messageView, duration: 1.0, options: transitionOptions, animations: {
                            self.messageView.hidden = true
                            }, completion: { finished in
                                // any code entered here will be applied
                                // once the animation has completed
                                
                        })
                })
        })

    }
    
    /*
This function is dealing with the delegate CLLocationManagerDelegate
    When and if the app succesfully obtains the users location this will be called. Then it will append the users location to an array called locations
*/
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // println("Successfully updated location")
          NSLog("%lf", cLLocationManager.location!)
                    let span = MKCoordinateSpanMake(0.008, 0.008)
                    let region = MKCoordinateRegion(center: cLLocationManager.location!.coordinate, span: span)
                    mapView.setRegion(region, animated: true)
     mapView.zoomEnabled = true
        mapView.rotateEnabled = true
        mapView.scrollEnabled = true
        usedCurrentLocation = true

        messageTextLabel.text = "When current location is selected you can zoom and scroll like a normal map"
        self.animateMessageView()
        // Only stop updating location when the accuracy of the gps is within 100 meters
        if(cLLocationManager.location.horizontalAccuracy > 0 && cLLocationManager.location.horizontalAccuracy < 100)
        {
        cLLocationManager.stopUpdatingLocation()
        }
    }
    
    /*
This function has to do with the MKMapViewDelegate
    When the user adds an annotation on the map this function is called.
    In order to display the user's current location this function must return nil for the MKUserLocation
*/
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if(annotation.isKindOfClass(MKUserLocation))
        {
            return nil
        }
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotation.title) as! MKPinAnnotationView?
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.title)
            // pinView!.calloutOffset = CGPoint(x: -5, y: 5)
            //pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            pinView!.canShowCallout = false
            pinView!.animatesDrop = true
            pinView!.pinColor = .Green
            pinView!.draggable = true;
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    // If for some reason the map fails loading notify the user
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        let alert = UIAlertController(title: "Map View Failed To Load" , message: "Please connect to a stronger connection to load the map.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // This is the function to be called before the segue is perfomed 
    // instead of passing the view using a push segue I will be using a modal Presentation style
    // Specifically the popover presentation style MUST INCLUDE THE UIPopoverPresentationControllerDelegate in the view controller!!!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(segue.identifier == "listView")
       {
        let popoverViewController = segue.destinationViewController as! CapitalsList
        popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        popoverViewController.popoverPresentationController!.delegate = self
        
        }
        
    }
    /// When the unwind segue is called I should dismiss the view controller ( the popover presentation view segue'd to earlier
    // Then I will use the 'id' number of the passed CapitalState and set up coordinates
    @IBAction func unwindFromListCapitalViewController(unwindSegue: UIStoryboardSegue)
    {
    self.dismissViewControllerAnimated(true, completion: nil)
        // println("called")
        setUpCoordinates()
    }
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Randomly generate a random number between 0 and 50
    func randomNumberBetweenZeroAndFifty() -> Int
    {
        var randomNumber: UInt32 = arc4random() % 50
        println("The value of random number is: \(randomNumber)")
        return Int(randomNumber)
    }
    // This is the function dealing with the segmented control on the map 
    // it allows the user to switch between a standard map, a satallite map and a hybrid one
    @IBAction func mapType(sender: AnyObject) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapType.Standard
            break;
        case 1:
            mapView.mapType = MKMapType.Satellite
            break;
        case 2:
            mapView.mapType = MKMapType.Hybrid
            break;
            
        default:
            break;
        }
    }


}

