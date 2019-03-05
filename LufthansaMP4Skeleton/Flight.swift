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
    
    var timeStatus: String!
    
    init(data: JSON) {
        timeStatus = data["FlightStatusResource"]["Flights"]["Flight"]["Departure"]["TimeStatus"]["Definition"].stringValue
    }
}
