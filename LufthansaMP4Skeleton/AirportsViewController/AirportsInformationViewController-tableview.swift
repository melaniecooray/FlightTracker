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
        if toShow[indexPath[1]].destinationAirport == airport.title! {
            cell.flightTime.text = toShow[indexPath[1]].arrivalTime!
        } else {
            cell.flightTime.text = toShow[indexPath[1]].departureTime!
        }
        return cell
    }
    
    
}
