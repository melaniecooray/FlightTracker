//
//  Aircraft.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/6/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import SwiftyJSON

class Aircraft {
    var aircraftCode: String!
    var aircraftName: String!
    
    init(data: JSON) {
        aircraftName = data["AircraftResource"]["AircraftSummaries"]["AircraftSummary"]["Names"]["Name"]["$"].stringValue
        aircraftCode = data["AircraftResource"]["AircraftSummaries"]["AircraftSummary"]["AircraftCode"].stringValue
    }
}

