//
//  AirportsInformationViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class AirportsInformationViewController: UIViewController {
    
    var airport: Airport!
    var mapView: MKMapView!
    
    var tableView: UITableView!
    var customSC: UISegmentedControl!
    
    var departures: [Flight] = []
    var arrivals: [Flight] = []
    var toShow: [Flight] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        setupSegmentedControl()
        centerMap()
        createAnnotations()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        let final = result + "T12:00"
        getFlights(date: final)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "\(airport.subtitle!)"
    }
    
    func createMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height/3))
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func centerMap() {
        let region = MKCoordinateRegion(center: airport.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(region, animated : true)
    }
    
    func createAnnotations() {
        mapView.addAnnotation(airport)
    }
    
    @objc func indexChanged(_ sender: Any) {
        switch customSC.selectedSegmentIndex {
        case 0 : displayDepartures()
        case 1: displayArrivals()
        default: break
        }
    }

    func getFlights(date: String) {
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getFlightsFrom(type: "departures", airportCode: "\(self.airport.title!)", currentDate: "\(date)") { flts in
                //self.label.text = flt.timeStatus
                self.departures = flts
                LufthansaAPIClient.getFlightsFrom(type: "arrivals", airportCode: "\(self.airport.title!)", currentDate: "\(date)") { arrs in
                    self.arrivals = arrs
                    self.toShow = self.departures
                    self.displayList()
                    //print(self.toShow)
                }
            }
        }
    }
}
