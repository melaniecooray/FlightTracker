//
//  Flight.swift
//  LufthansaMP4Skeleton
//
//  Created by Max Miranda on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import SwiftyJSON

class Flight {
    
    var flightNumber: String!
    
    var timeStatus: String!
    
    var departureTime: String!
    var arrivalTime: String!
    
    var originAirport: String!
    var destinationAirport: String!
    
    var originGate: String!
    var destinationGate: String!
    
    var airline: String!
    var aircraft: String!
    
    var favorite: Bool!
    var aircraftObject: Aircraft!
    var originAirportObject: Airport!
    var destinationAirportObject: Airport!
    
    init(data: JSON) {
        airline = data["MarketingCarrier"]["AirlineID"].stringValue
        aircraft = data["Equipment"]["AircraftCode"].stringValue
        flightNumber = data["MarketingCarrier"]["FlightNumber"].stringValue
        timeStatus = data["Departure"]["TimeStatus"]["Definition"].stringValue
        
        departureTime = data["Departure"]["ScheduledTimeLocal"]["DateTime"].stringValue
        arrivalTime = data["Arrival"]["ScheduledTimeLocal"]["DateTime"].stringValue
        
        originAirport = data["Departure"]["AirportCode"].stringValue
        destinationAirport = data["Arrival"]["AirportCode"].stringValue
        
        favorite = false
    }
}
