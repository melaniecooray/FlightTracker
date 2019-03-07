//
//  FlightStatusViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FlightStatusViewController: UIViewController {
    
    var image: UIImageView!
    var titleLabel: UILabel!
    var button: UIButton!
    
    var flightNumberTextField: UITextField!
    
    var datePicker: UIDatePicker!
    var selectedDate: String!
    
    var loadingScreen: UIView!
    var loadingText: UILabel!
    
    var flight: Flight!
    var originAirport: Airport!
    var destinationAirport: Airport!
    var aircraft: Aircraft!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: "favoritesCount")
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if loadingScreen != nil {
            loadingScreen.removeFromSuperview()
            loadingText.removeFromSuperview()
        }
    }
    
    func animateImage(){
        UIView.animate(withDuration: 4, animations: {
            self.image.frame = CGRect(x: self.view.frame.maxX + 300, y: 400, width: 300, height: 200)
        }) { (done) in
            self.image.frame = CGRect(x: -300, y: 500, width: 300, height: 200)
        }
    }
    
    @objc func buttonPress(_ sender: Any) {
        
        //Gets new auth token and then gets flight status once that is successful
        guard let flightNumber = flightNumberTextField.text else {
            showError(title: "Information Missing", message: "No Flight Number Entered.")
            return
        }
        
        self.loadingScreen = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.loadingScreen.backgroundColor = .white
        self.view.addSubview(self.loadingScreen)
        self.loadingText = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        self.loadingText.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        self.loadingText.text = "Loading..."
        self.loadingText.textAlignment = .center
        self.view.addSubview(self.loadingText)
    
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getFlightStatus(flightNum: "\(flightNumber)", date: "\(self.selectedDate!)") { flt in
                //print(flt.timeStatus)
                //self.label.text = flt.timeStatus
                self.flight = flt
                LufthansaAPIClient.getAirport(airportCode: self.flight.originAirport!) { air in
                    self.originAirport = air
                    self.flight.originAirportObject = air
                    //print(air.title)
                    //print(air.coordinate)
                    LufthansaAPIClient.getAirport(airportCode: self.flight.destinationAirport!) { air in
                        self.destinationAirport = air
                        self.flight.destinationAirportObject = air
                        //print(air.title)
                        //print(air.coordinate)
                        LufthansaAPIClient.getAircraft(type: self.flight.aircraft!) { craft in
                            self.aircraft = craft
                            self.flight.aircraftObject = self.aircraft
                            print(self.flight.aircraftObject)
                            self.performSegue(withIdentifier: "toFlightInformation", sender: self)
                        }
                    }
                }
            }
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? FlightInformationViewController {
            resultVC.flight = flight
            resultVC.originAirport = originAirport
            resultVC.destinationAirport = destinationAirport
            resultVC.date = selectedDate
            resultVC.aircraft = aircraft
        }
    }
    
}
