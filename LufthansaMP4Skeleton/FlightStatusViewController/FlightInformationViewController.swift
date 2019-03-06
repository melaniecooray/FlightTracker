//
//  FlightInformationViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/4/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class FlightInformationViewController: UIViewController {
    
    var backgroundColor: UIColor!
    
    var flight: Flight!
    var originAirport: Airport!
    var destinationAirport: Airport!
    
    var timeStatusLabel: UILabel!
    
    var depAirportButton: UIButton!
    var arrAirportButton: UIButton!
    
    var depTimeLabel: UILabel!
    var arrTimeLabel: UILabel!
    
    var depGateLabel: UILabel!
    var arrGateLabel: UILabel!
    
    var favoriteButton: UIBarButtonItem!
    var favorite = false
    
    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        createAirports()
        centerMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "LH\(flight.flightNumber!)"
    }
    
    @objc func saveToFavorites() {
        favorite = true
        print("Favorite!")
    }
    
    func createAirports() {
        //let origin = Airport(location: CLLocationCoordinate2D(latitude: 37.866632800000005, longitude: -122.25206805335353), name: "Max", hobby: "Being a Complete Baller")
        mapView.addAnnotation(originAirport)
        mapView.addAnnotation(destinationAirport)
    }
    
    func centerMap() {
        let midPointlat = (originAirport.latitude + destinationAirport.latitude) / 2
        let midPointlong = (originAirport.longitude + destinationAirport.longitude) / 2
        let location = CLLocationCoordinate2D(latitude: midPointlat, longitude: midPointlong)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
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
