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
    var label: UILabel!
    var button: UIButton!
    
    var flightNumberTextField: UITextField!
    
    var datePicker: UIDatePicker!
    var selectedDate: String!
    
    var flight: Flight!
    var originAirport: Airport!
    var destinationAirport: Airport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
    
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getFlightStatus(flightNum: "\(flightNumber)", date: "\(self.selectedDate!)") { flt in
                print(flt.timeStatus)
                //self.label.text = flt.timeStatus
                self.flight = flt
                LufthansaAPIClient.getAirport(airportCode: self.flight.originAirport!) { air in
                    self.originAirport = air
                    print(air.title)
                    print(air.coordinate)
                    LufthansaAPIClient.getAirport(airportCode: self.flight.destinationAirport!) { air in
                        self.destinationAirport = air
                        print(air.title)
                        print(air.coordinate)
                        self.performSegue(withIdentifier: "toFlightInformation", sender: self)
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
        }
    }
    
}
