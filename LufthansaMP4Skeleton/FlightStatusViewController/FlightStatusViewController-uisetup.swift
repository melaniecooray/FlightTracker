//
//  FlightStatusViewController-uisetup.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/4/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

extension FlightStatusViewController {
    
    func initUI(){
        
        //self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 139/255, alpha: 1)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cloud.png")!)
        
        setupTitle()
        setupFlightNumber()
        setupDatePicker()
        setupButton()
    }
    
    func setupTitle() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: 200)
        titleLabel.text = "Flight Tracker"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 50)
        view.addSubview(titleLabel)
    }
    
    func setupFlightNumber() {
        flightNumberTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width - 100, height: 50))
        flightNumberTextField.center = CGPoint(x: view.frame.width/2, y: titleLabel.frame.maxY + 50)
        flightNumberTextField.placeholder = "Flight Number"
        flightNumberTextField.adjustsFontSizeToFitWidth = true
        flightNumberTextField.layer.cornerRadius = 10
        flightNumberTextField.backgroundColor = .white
        view.addSubview(flightNumberTextField)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width - 50, height: 200)
        datePicker.center = CGPoint(x: view.frame.width/2, y: flightNumberTextField.frame.maxY + 150)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
    }
    
    func setupButton() {
        button = UIButton(frame: CGRect(x: 50, y: 0, width: view.frame.width - 100, height: 50))
        button.center = CGPoint(x: view.frame.width/2, y: datePicker.frame.maxY + 100)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setTitle("Get Flight Status", for: .normal)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        view.addSubview(button)
    }
    
}
