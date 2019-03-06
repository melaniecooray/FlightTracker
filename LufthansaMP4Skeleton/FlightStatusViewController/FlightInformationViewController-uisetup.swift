//
//  FlightInformationViewController-uisetup.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

extension FlightInformationViewController {
    func initUI() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 139/255, alpha: 1)
        self.view.backgroundColor = backgroundColor
        favoriteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveToFavorites))
        self.navigationItem.setRightBarButton(favoriteButton, animated: true)
        setupTimeStatus()
        setupDepAirportButton()
        setupArrAirportButton()
        setupDepTime()
        setupArrTime()
        setupMap()
    }
    
    func setupTimeStatus() {
        timeStatusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        timeStatusLabel.center = CGPoint(x: view.frame.width/2, y: 200)
        timeStatusLabel.text = flight.timeStatus
        timeStatusLabel.textColor = .white
        timeStatusLabel.textAlignment = .center
        view.addSubview(timeStatusLabel)
    }
    
    func setupDepAirportButton() {
        depAirportButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: 100))
        depAirportButton.center = CGPoint(x: view.frame.width/4, y: timeStatusLabel.frame.maxY + 50)
        depAirportButton.backgroundColor = backgroundColor
        depAirportButton.setTitle("\(flight.originAirport!)", for: .normal)
        depAirportButton.setTitleColor(.white, for: .normal)
        view.addSubview(depAirportButton)
    }
    
    func setupArrAirportButton() {
        arrAirportButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: 100))
        arrAirportButton.center = CGPoint(x: (view.frame.width/4) * 3, y: timeStatusLabel.frame.maxY + 50)
        arrAirportButton.backgroundColor = backgroundColor
        arrAirportButton.setTitle("\(flight.destinationAirport!)", for: .normal)
        arrAirportButton.setTitleColor(.white, for: .normal)
        view.addSubview(arrAirportButton)
    }
    
    func setupDepTime() {
        depTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        depTimeLabel.center = CGPoint(x: depAirportButton.frame.midX, y: depAirportButton.frame.maxY + 50)
        depTimeLabel.textAlignment = .center
        depTimeLabel.text = "\(flight.departureTime!)"
        depTimeLabel.textColor = .white
        view.addSubview(depTimeLabel)
    }
    
    func setupArrTime() {
        arrTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        arrTimeLabel.center = CGPoint(x: arrAirportButton.frame.midX, y: arrAirportButton.frame.maxY + 50)
        arrTimeLabel.textAlignment = .center
        arrTimeLabel.text = "\(flight.arrivalTime!)"
        arrTimeLabel.textColor = .white
        view.addSubview(arrTimeLabel)
    }
    
    func setupMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: 500, width: view.frame.width, height: 200))
        mapView.delegate = self
        view.addSubview(mapView)
    }
}
