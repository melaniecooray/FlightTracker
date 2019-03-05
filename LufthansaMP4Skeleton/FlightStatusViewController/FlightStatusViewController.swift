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
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getFlightStatus(flightNum: "\(self.flightNumberTextField.text!)", date: "\(self.selectedDate!)") { flt in
                print(flt.timeStatus)
                //self.label.text = flt.timeStatus
                self.animateImage()
            }
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        if currentDate > sender.date {
            showError(title: "Error:", message: "Selected date cannot be earlier than current date")
        }
        selectedDate = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
