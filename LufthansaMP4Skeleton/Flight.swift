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
    
    init(data: JSON) {
        flightNumber = data["FlightStatusResource"]["Flights"]["Flight"]["MarketingCarrier"]["FlightNumber"].stringValue
        timeStatus = data["FlightStatusResource"]["Flights"]["Flight"]["Departure"]["TimeStatus"]["Definition"].stringValue
        
        departureTime = data["FlightStatusResource"]["Flights"]["Flight"]["Departure"]["ScheduledTimeLocal"]["DateTime"].stringValue
        arrivalTime = data["FlightStatusResource"]["Flights"]["Flight"]["Arrival"]["ScheduledTimeLocal"]["DateTime"].stringValue
        
        originAirport = data["FlightStatusResource"]["Flights"]["Flight"]["Departure"]["AirportCode"].stringValue
        destinationAirport = data["FlightStatusResource"]["Flights"]["Flight"]["Arrival"]["AirportCode"].stringValue
    }
}
