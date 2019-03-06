//
//  AirportsViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class AirportsViewController: UIViewController {
    
    var mapView: MKMapView!
    var airports: [Airport] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        loadAirports()
    }
    
    func loadAirports() {
        LufthansaAPIClient.getAuthToken {
            LufthansaAPIClient.getLHAirports() { lst in
                for i in 0..<lst.count {
                    self.airports.append(lst[i])
                    //print(lst[i].title)
                }
                self.createMap()
                self.centerMap()
                self.createAnnotations()
            }
        }
    }
    
    func createMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func createAnnotations() {
        for airport in airports {
            mapView.addAnnotation(airport)
        }
    }
    
    func centerMap() {
        let location = CLLocationCoordinate2D(latitude: 54.5260, longitude: 15.2551)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 3000000, longitudinalMeters: 3000000)
        self.mapView.setRegion(region, animated : true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
