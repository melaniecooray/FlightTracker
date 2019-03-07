//
//  AirportsViewController-map.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

extension AirportsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //print("In MKMapViewDelegate")
        guard let annotation = annotation as? Airport else {
            return nil
        }
        let identifier = "marker"
        let view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            //print("Created a new view")
            //print(annotation.title)
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped: UIControl) {
        selectedAirport = annotationView.annotation as? Airport
        performSegue(withIdentifier: "toAirportInformation", sender: self)
    }
}
