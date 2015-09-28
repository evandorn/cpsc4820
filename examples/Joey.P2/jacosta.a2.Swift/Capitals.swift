//
//  Capitals.swift
//  jacosta.a2.Swift
//
//  Created by Joey Costa on 9/14/15.
//  Copyright (c) 2015 Joey Costa. All rights reserved.
//


import Foundation
import UIKit
/*
This is the state capitals class I am usign for the application
As you can see here a StateCapital is made up of an 
id
state 
capital
abbreviation
longitude
latitude
region

When creating a custom class it always needs a default initilizer. I also have created a custom initilizer to initilize a type StateCapital to contain the information I want
*/
class StateCapitals
{
    let id: Int
    let state: String
    let capital: String
    let abbreviation: String
    let latitude: Double
    let longitude: Double
    let region: Int
    
    
    init(id: Int, stateName: String, capitalName: String, abbrev: String, lat: Double, long: Double, regionSize: Int)
    {
        self.id = id
        state = stateName
        capital = capitalName
        abbreviation = abbrev
        latitude = lat
        longitude = long
        region = regionSize
    }
    init()
    {
        id = 0
        state = ""
        capital = ""
        abbreviation = ""
        latitude = 0.0
        longitude = 0.0
        region = 0
        
    }
    /* This class function can be called on any object that is of type StateCapital
    This function returns an array of statecapital objects
    As you notice below I have created an array of all 50 state capitals
    */
    class func allStateCapitals() -> [StateCapitals]
    {
        return [StateCapitals(id: 0, stateName: "Alabama", capitalName: "Montgomery", abbrev: "AL", lat: 32.380120, long: -86.300629, regionSize: 10000),
            StateCapitals(id: 1, stateName: "Alaska", capitalName: "Juneau", abbrev: "AK", lat: 58.299740, long: -134.406794, regionSize: 1000),
            StateCapitals(id: 2, stateName: "Arizona", capitalName: "Pheonix", abbrev: "AZ", lat: 33.448260, long: -112.075774, regionSize: 40000),
            StateCapitals(id: 3, stateName: "Arkansas", capitalName: "Little Rock", abbrev: "AR", lat: 34.748655, long: -92.274494, regionSize: 30000),
            StateCapitals(id: 4, stateName: "California", capitalName: "Sacramento", abbrev: "CA", lat: 38.579065, long: -121.491014, regionSize: 30000),
            StateCapitals(id: 5, stateName: "Colorado", capitalName: "Denver", abbrev: "CO", lat: 39.740010, long: -104.992259, regionSize: 40000),
        StateCapitals(id: 6, stateName: "Connecticut", capitalName: "HartFord", abbrev: "CT", lat: 41.763325, long: -72.674069, regionSize: 30000),
        StateCapitals(id: 7, stateName: "Delaware", capitalName: "Dover", abbrev: "DE", lat: 39.158035, long: -75.524734, regionSize: 15000),
        StateCapitals(id: 8, stateName: "Florida", capitalName: "Tallahassee", abbrev: "FL", lat: 30.439775, long: -84.280649, regionSize: 25000),
        StateCapitals(id: 9, stateName: "Georgia", capitalName: "Atlanta", abbrev: "GA", lat: 33.748315, long: -84.391109, regionSize: 40000),
        StateCapitals(id: 10, stateName: "Hawaii", capitalName: "Honolulu", abbrev: "HI", lat: 21.304770, long: -157.857614, regionSize: 20000),
        StateCapitals(id: 11, stateName: "Idaho", capitalName: "Boise", abbrev: "ID", lat: 43.606980, long: -116.193409, regionSize: 15000),
        StateCapitals(id: 12, stateName: "Illinois", capitalName: "Springfield", abbrev: "IL", lat: 39.801055, long: -89.643604, regionSize: 25000),
        StateCapitals(id: 13, stateName: "Indiana", capitalName: "Indianapolis", abbrev: "IN", lat: 39.766910, long: -86.149964, regionSize: 45000),
        StateCapitals(id: 14, stateName: "Iowa", capitalName: "Des Moines", abbrev: "IA", lat: 41.589790, long: -93.615659, regionSize: 45000),
        StateCapitals(id: 15, stateName: "Kansas", capitalName: "Topeka", abbrev: "KS", lat: 39.049285, long: -95.671184, regionSize: 20000),
        StateCapitals(id: 16, stateName: "Kentucky", capitalName: "Frankfort", abbrev: "KY", lat: 38.195070, long: -84.878694, regionSize: 10000),
            StateCapitals(id: 17, stateName: "Louisiana", capitalName: "Baton Rouge", abbrev: "LA", lat: 30.443345, long: -91.186994, regionSize: 35000),
        StateCapitals(id: 18, stateName: "Maine", capitalName: "Augusta", abbrev: "ME", lat: 44.318036, long: -69.776218, regionSize: 7000),
        StateCapitals(id: 19, stateName: "Maryland", capitalName: "Annapolis", abbrev: "MD", lat: 38.976700, long: -76.489934, regionSize: 5000),
        StateCapitals(id: 20, stateName: "Massachusetts", capitalName: "Boston", abbrev: "MA", lat: 42.358635, long: -71.056699, regionSize: 50000),
        StateCapitals(id: 21, stateName: "Michigan", capitalName: "Lansing", abbrev: "MI", lat: 42.731940, long: -84.552249, regionSize: 25000),
        StateCapitals(id: 22, stateName: "Minnesota", capitalName: "St. Paul", abbrev: "MN", lat: 44.943829, long: -93.093326, regionSize: 15000),
        StateCapitals(id: 23, stateName: "Mississippi", capitalName: "Jackson", abbrev: "MS", lat: 32.298690, long: -90.180489, regionSize: 30000),
            StateCapitals(id: 24, stateName: "Missouri", capitalName: "Jefferson City", abbrev: "MO", lat: 38.577515, long: -92.177839, regionSize: 12000),
        StateCapitals(id: 25, stateName: "Montana", capitalName: "Helena", abbrev: "MT", lat: 46.589760, long: -112.021202, regionSize: 7000),
        StateCapitals(id: 26, stateName: "Nebraska", capitalName: "Lincoln", abbrev: "NE", lat: 40.813620, long: -96.707739, regionSize: 10000),
        StateCapitals(id: 27, stateName: "Nevada", capitalName: "Carson City", abbrev: "NV", lat: 39.164885, long: -119.766999, regionSize: 10000),
        StateCapitals(id: 28, stateName: "New Hampshire", capitalName: "Concord", abbrev: "NH", lat: 43.207250, long: -71.536604, regionSize: 7000),
        StateCapitals(id: 29, stateName: "New Jersey", capitalName: "Trenton", abbrev: "NJ", lat: 40.217875, long: -74.759404, regionSize: 30000),
        StateCapitals(id: 30, stateName: "New Mexico", capitalName: "Santa Fe", abbrev: "NM", lat: 35.691543, long: -105.937406, regionSize: 8000),
        StateCapitals(id: 31, stateName: "New York", capitalName: "Albany", abbrev: "NY", lat: 42.651445, long: -73.755254, regionSize: 20000),
        StateCapitals(id: 32, stateName: "North Carolina", capitalName: "Raleigh", abbrev: "NC", lat: 35.785510, long: -78.642669, regionSize: 20500),
        StateCapitals(id: 33, stateName: "North Dakota", capitalName: "Bismarck", abbrev: "ND", lat: 46.805372, long: -100.779334, regionSize: 10000),
        StateCapitals(id: 34, stateName: "Ohio", capitalName: "Columbus", abbrev: "OH", lat: 39.961960, long: -83.002984, regionSize: 50000),
        StateCapitals(id: 35, stateName: "Oklahoma", capitalName: "Oklahoma City", abbrev: "OK", lat: 35.472015, long: -97.520354, regionSize: 50000),
        StateCapitals(id: 36, stateName: "Oregon", capitalName: "Salem", abbrev: "OR", lat: 44.933260, long: -123.043814, regionSize: 8000),
        StateCapitals(id: 37, stateName: "Pennsylvania", capitalName: "Harrisburg", abbrev: "PA", lat: 40.259865, long: -76.882230, regionSize: 20000),
        StateCapitals(id: 38, stateName: "Rhode Island", capitalName: "Providence", abbrev: "RI", lat: 41.823875, long: -71.411994, regionSize: 10000),
        StateCapitals(id: 39, stateName: "South Carolina", capitalName: "Columbia", abbrev: "SC", lat: 33.998550, long: -81.045249, regionSize: 30000),
        StateCapitals(id: 40, stateName: "South Dakota", capitalName: "Pierre", abbrev: "SD", lat: 44.368924, long: -100.350158, regionSize: 6000),
        StateCapitals(id: 41, stateName: "Tennessee", capitalName: "Nashville", abbrev: "TN", lat: 36.167783, long: -86.778365, regionSize: 10000),
        StateCapitals(id: 42, stateName: "Texas", capitalName: "Austin", abbrev: "TX", lat: 30.267605, long: -97.742984, regionSize: 20000),
        StateCapitals(id: 43, stateName: "Utah", capitalName: "Salt Lake City", abbrev: "UT", lat: 40.759505, long: -111.888229, regionSize: 30000),
        StateCapitals(id: 44, stateName: "Vermont", capitalName: "Montpelier", abbrev: "VT", lat: 44.260299, long: -72.576264, regionSize: 7000),
        StateCapitals(id: 45, stateName: "Virginia", capitalName: "Richmond", abbrev: "VA", lat: 37.540700, long: -77.433654, regionSize: 20000),
        StateCapitals(id: 46, stateName: "Washington", capitalName: "Olympia", abbrev: "WA", lat: 47.039231, long: -122.891366, regionSize: 5000),
        StateCapitals(id: 47, stateName: "West Virginia", capitalName: "Charleston", abbrev: "WV", lat: 38.350195, long: -81.638989, regionSize: 8000),
        StateCapitals(id: 48, stateName: "Wisconsin", capitalName: "Madison", abbrev: "WI", lat: 43.072950, long: -89.386694, regionSize: 20000),
        StateCapitals(id: 49, stateName: "Wyoming", capitalName: "Cheyenne", abbrev: "WY", lat: 41.134815, long: -104.821544, regionSize: 10000)]
    }
}