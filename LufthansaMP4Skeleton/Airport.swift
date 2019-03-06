//
//  Airport.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

class Airport: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var latitude: Double!
    var longitude: Double!
    var title: String?
    var subtitle: String?
    
    init(data: JSON) {
        latitude = data["Position"]["Coordinate"]["Latitude"].doubleValue
        longitude = data["Position"]["Coordinate"]["Longitude"].doubleValue
        coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        title = data["AirportCode"].stringValue
        subtitle = data["Names"]["Name"]["$"].stringValue
    }
}
