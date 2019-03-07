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
        //backgroundColor = UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1)
        backgroundColor = .white
        self.view.backgroundColor = backgroundColor
        if flight.favorite == false {
            favoriteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveToFavorites))
            self.navigationItem.setRightBarButton(favoriteButton, animated: true)
        } else {
            favoriteButton = UIBarButtonItem(title: "Saved!", style: .plain, target: self, action: nil)
            self.navigationItem.setRightBarButton(favoriteButton, animated: true)
        }
        setupTimeStatus()
        setupDepAirportButton()
        setupArrAirportButton()
        setupArrow()
        setupDepTime()
        setupArrTime()
        setupMap()
        setupAircraft()
    }
    
    func setupTimeStatus() {
        timeStatusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        timeStatusLabel.center = CGPoint(x: view.frame.width/2, y: 350)
        timeStatusLabel.text = flight.timeStatus
        timeStatusLabel.textColor = .black
        timeStatusLabel.textAlignment = .center
        timeStatusLabel.font = UIFont(name: "Avenir-Light", size: 50)
        view.addSubview(timeStatusLabel)
    }
    
    func setupDepAirportButton() {
        depAirportButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: 100))
        depAirportButton.center = CGPoint(x: view.frame.width/4, y: timeStatusLabel.frame.maxY + 75)
        depAirportButton.backgroundColor = backgroundColor
        depAirportButton.setTitle("\(flight.originAirport!)", for: .normal)
        depAirportButton.setTitleColor(.black, for: .normal)
        depAirportButton.titleLabel?.font =  UIFont(name: "Avenir-Light", size: 40)
        depAirportButton.addTarget(self, action: #selector(depairportClicked), for: .touchUpInside)
        view.addSubview(depAirportButton)
    }
    
    func setupArrAirportButton() {
        arrAirportButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: 100))
        arrAirportButton.center = CGPoint(x: (view.frame.width/4) * 3, y: timeStatusLabel.frame.maxY + 75)
        arrAirportButton.backgroundColor = backgroundColor
        arrAirportButton.setTitle("\(flight.destinationAirport!)", for: .normal)
        arrAirportButton.setTitleColor(.black, for: .normal)
        arrAirportButton.titleLabel?.font =  UIFont(name: "Avenir-Light", size: 40)
        arrAirportButton.addTarget(self, action: #selector(arrairportClicked), for: .touchUpInside)
        view.addSubview(arrAirportButton)
    }
    
    func setupArrow() {
        arrow = UIImage(named: "whitearrow.png")
        arrowView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        arrowView.center = CGPoint(x: view.frame.width/2, y: timeStatusLabel.frame.maxY + 125)
        arrowView.image = arrow
        view.addSubview(arrowView)
    }
    
    func setupDepTime() {
        depTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        depTimeLabel.center = CGPoint(x: depAirportButton.frame.midX, y: depAirportButton.frame.maxY + 50)
        depTimeLabel.textAlignment = .center
        let date = flight.departureTime!
        let index = date.index(date.endIndex, offsetBy: -5)
        let substring = date[index...]
        depTimeLabel.text = String(substring)
        depTimeLabel.textColor = .black
        depTimeLabel.font = UIFont(name: "Avenir-Light", size: 30)
        view.addSubview(depTimeLabel)
    }
    
    func setupArrTime() {
        arrTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        arrTimeLabel.center = CGPoint(x: arrAirportButton.frame.midX, y: arrAirportButton.frame.maxY + 50)
        arrTimeLabel.textAlignment = .center
        let date = flight.arrivalTime!
        let index = date.index(date.endIndex, offsetBy: -5)
        let substring = date[index...]
        arrTimeLabel.text = String(substring)
        arrTimeLabel.textColor = .black
        arrTimeLabel.font = UIFont(name: "Avenir-Light", size: 30)
        view.addSubview(arrTimeLabel)
    }
    
    func setupMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: 200))
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func setupAircraft() {
        aircraftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        aircraftLabel.center = CGPoint(x: view.frame.width/2, y: 650)
        print(flight.aircraftObject)
        aircraftLabel.text = flight.aircraftObject.aircraftName!
        aircraftLabel.textAlignment = .center
        aircraftLabel.textColor = .black
        aircraftLabel.font = UIFont(name: "Avenir-Light", size: 15)
        view.addSubview(aircraftLabel)
    }
}
