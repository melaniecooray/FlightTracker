//
//  AirportsInformationViewController-tableview.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit


extension AirportsInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toShow.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightList", for: indexPath) as! DepartureCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.flightNum.text = toShow[indexPath[1]].airline + toShow[indexPath[1]].flightNumber!
        var date = toShow[indexPath[1]].departureTime!
        if toShow[indexPath[1]].destinationAirport == airport.title! {
            date = toShow[indexPath[1]].arrivalTime!
        }
        let index = date.index(date.endIndex, offsetBy: -5)
        let index2 = date.index(date.endIndex, offsetBy: -7)
        let substring2 = date[index...]
        let substring1 = date[...index2]
        cell.flightTime.text = String(substring1 + "   " + substring2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loadingScreen = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.loadingScreen.backgroundColor = .white
        self.view.addSubview(self.loadingScreen)
        self.loadingText = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        self.loadingText.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        self.loadingText.text = "Loading..."
        self.loadingText.textAlignment = .center
        self.view.addSubview(self.loadingText)
        selectedFlight = toShow[indexPath[1]]
        LufthansaAPIClient.getAuthToken {
            LufthansaAPIClient.getAircraft(type: self.selectedFlight.aircraft) { air in
                LufthansaAPIClient.getAirport(airportCode: self.selectedFlight.originAirport) { origin in
                    LufthansaAPIClient.getAirport(airportCode: self.selectedFlight.destinationAirport) { dest in
                        self.selectedFlight.aircraftObject = air
                        self.selectedFlight.originAirportObject = origin
                        self.selectedFlight.destinationAirportObject = dest
                        tableView.deselectRow(at: indexPath, animated: true)
                        self.segue()
                    }
                }
            }
        }
    }
    
}
