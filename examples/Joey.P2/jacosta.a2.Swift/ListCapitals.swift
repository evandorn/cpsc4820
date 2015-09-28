//
//  ListCapitals.swift
//  jacosta.a2.Swift
//
//  Created by Joey Costa on 9/14/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//

import Foundation
import UIKit
// Enum a type searchCriteria to limit on how people search object
// this is used in the segmented control to decide what the user wants to search by
// search by capital, state, or abbreviation
enum SearchCriteria
{
    case Capital
    case State
    case Abbreviation
}

class CapitalsList: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    @IBOutlet weak var searchTextField: UISearchBar!
    
    @IBOutlet weak var searchBy: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var StateCapitalArray: Array<StateCapitals>!
    var selectedIndexInTableView: Int = 0
    var limitedStateCapitalArray: [StateCapitals]!
    
    var searchByText: SearchCriteria = .Capital
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StateCapitalArray = StateCapitals.allStateCapitals()
        limitedStateCapitalArray = StateCapitalArray
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchTextField.delegate = self
        self.searchTextField.showsSearchResultsButton = true
        
        
        
    }
    /*
UISearchBarDelegate methods
    If the user clicks the search button or the user clicks the cancel button
    then we should resign the first responder. or force the view to end all editing


*/
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    /*
This is the segment control. This will allow the user to select how they search for information.
    Whether they want to search by capital, state, or abbreviation
*/
    @IBAction func searchBarByContent(sender: AnyObject) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.searchByText = .Capital;
            break;
        case 1:
            self.searchByText = .State;
            break;
        case 2:
            self.searchByText = .Abbreviation;
            break;
            
        default:
            break;
        }
        // revert the search for no bugs
        limitedStateCapitalArray = StateCapitalArray
    searchTextField.text = ""
        tableView.reloadData()
    }
    
    /*
The searchBar textDidChange function has to do with the Delegate function of UISearchBarDelegate
    This function is called after every change to the search bar text. I will be using this function to narrow the results of the capitals list based on the search text. 
    If the text box is empty then all capitals should be shown. If the text box isnt empty then based on the text i should check against the corresponding search criteria if the object exists. 
    I am using swift's natural string.filter block statement.
    It is very similar to a for loop. Instead of creating a loop like
    
    for(var i = 0; i < StateCapitalArray.count; i++)
    {
    if(StateCapitalArray[i].containsString(searchText.uppercaseString))
    {
     this item exists in the array
    I should append it to a new array
    and at the end of the for loop I will successfully have all the items
    }
    }
    
    
    All of that code can be shortened using a block statement
    Filter is an example of where block's can be used, sort is another example.
    
    var array: Array = Array(arrayLiteral: 5,1,6,2,8,3,4)
    
    to sort the array I can use the swift block format of sort.
    
    this function will sort the array from least to greatest.  As you can see the $0 references the first object implicitly and the $1 references the second object implicity. Sort will try and hold the statement true. The first object should be less than the second object. Then it will step through the array applying the rule to every object in the array making sure the first element is the least and the last element the greatest.
    
    array.sort({
    $0 < $1
    })
    
    println(array)
    
*/
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
   
        if(searchText.isEmpty)
        {
           limitedStateCapitalArray = StateCapitalArray
        }
        else
        {
            if(searchByText == .Capital)
            {
                self.limitedStateCapitalArray = self.StateCapitalArray.filter({
                    
                    NSString(string: $0.capital.uppercaseString).containsString(searchText.uppercaseString)
                    
                })
            }
           else if(searchByText == .State)
            {
        self.limitedStateCapitalArray = self.StateCapitalArray.filter({
         
            NSString(string: $0.state.uppercaseString).containsString(searchText.uppercaseString)
          
        })
            }
                else if(searchByText == .Abbreviation)
                {
                    self.limitedStateCapitalArray = self.StateCapitalArray.filter({
                        
                        NSString(string: $0.abbreviation).containsString(searchText.uppercaseString)
                        
                    })
                }
            
        }
        // Dont forget to reload the table view once the new array has been set
        self.tableView.reloadData()
    }
    // when the segue leaves the list capitals view the app should send back to the view controller which location the user selected. Because I always has the users current location set to 0 in the table view I have to offset the location by 1
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "selectedCapitalAndState")
        {
            let viewController: ViewController = segue.destinationViewController as! ViewController
            
            // the user selected current location
            if(selectedIndexInTableView == 0)
            {
                viewController.capitalNumber = 51 // send the view controller capital number 51 indicating current location
            }
            else
            {
                viewController.capitalNumber = selectedIndexInTableView - 1 // send the viewController the capital number minus one (since we added one row to the list of states)
            }
        }
    }
    // only 1 column in the table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // have the number of rows in the table view always be 1 more then the number of items in the limitedStateCapitalArray
    // This will allow me to place 'current location' in the list no matter what.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return limitedStateCapitalArray.count + 1 // add one so the user can select their own location
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: tableViewCell = tableView.dequeueReusableCellWithIdentifier("stateCell", forIndexPath: indexPath) as! tableViewCell
        // The first item in the table should ALWAYS be current location
        if(indexPath.row == 0)
        {
           cell.capitalName!.text = NSLocalizedString("Current Location", comment: "Current location")
            cell.fullState!.text = ""
            cell.abbrevState!.text = ""
        }
        else
        {
            // the other items in the table view should be based on the limitedStateCapitalArray
           cell.capitalName!.text = limitedStateCapitalArray[indexPath.row - 1].capital
            cell.fullState!.text = limitedStateCapitalArray[indexPath.row - 1].state
            cell.abbrevState!.text = limitedStateCapitalArray[indexPath.row - 1].abbreviation
        }
        return cell
    }
    // if the user selects an item in the table view first check to see which one the selected
    // if the user selected the first item then they selected 'current Location'
    // otherwise send the id (using the offset)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0)
        {
        selectedIndexInTableView = 0
            self.performSegueWithIdentifier("selectedCapitalAndState", sender: self)
        }
        else
        {
            println(indexPath.row)
        
        selectedIndexInTableView = limitedStateCapitalArray[indexPath.row - 1].id + 1
            //println(selectedIndexInTableView)
        self.performSegueWithIdentifier("selectedCapitalAndState", sender: self)
        }
    }
    
}

// This is used to create a custom UITableViewCell. I first drag an object of type UITableViewCell onto my storyboard viewController that has the table view (specifically this view controller) 
// Then I change the class of the new UITableViewCell to one of tableViewCell <- my custom class
// The above step is very similar on how to create new view Controllers and setting the view contoller to be based of a custom class
// This will allow me to change the layout/ or add other objects into my table view cell. Then I will be able to reference the newly created objects in that cell
class tableViewCell: UITableViewCell
{
    @IBOutlet weak var capitalName: UILabel!
    
    @IBOutlet weak var fullState: UILabel!
    @IBOutlet weak var abbrevState: UILabel!
    
    
    
}