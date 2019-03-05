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
        image = UIImageView(frame: CGRect(x: -300, y: 500, width: 300, height: 200))
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "plane")
        view.addSubview(image)
        
        setupFlightNumber()
        setupDatePicker()
        setupButton()
    }
    
    func setupFlightNumber() {
        flightNumberTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width - 100, height: 100))
        flightNumberTextField.center = CGPoint(x: view.frame.width/2, y: 300)
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
        datePicker.center = CGPoint(x: view.frame.width/2, y: flightNumberTextField.frame.maxY + 100)
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
