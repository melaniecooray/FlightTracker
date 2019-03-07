//
//  AirportsInformationViewController-uisetup.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

extension AirportsInformationViewController {
    func setupSegmentedControl() {
        let items = ["Departures", "Arrivals"]
        customSC = UISegmentedControl(items: items)
        customSC.frame = CGRect(x: 0, y: 0, width: 200, height: 25)
        customSC.center = CGPoint(x: view.frame.width/2, y: mapView.frame.maxY + 50)
        customSC.selectedSegmentIndex = 0
        
        customSC.layer.cornerRadius = 5;
        //self.navigationItem.titleView = customSC
        customSC.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        view.addSubview(customSC)
        view.bringSubviewToFront(customSC)
    }
    
    func displayList() {
        tableView = UITableView(frame: CGRect(x: 0, y: customSC.frame.maxY + 15, width: view.frame.width, height: 400))
        tableView.register(DepartureCell.self, forCellReuseIdentifier: "FlightList")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func displayDepartures() {
        toShow = departures
        tableView.reloadData()
    }
    
    func displayArrivals() {
        toShow = arrivals
        tableView.reloadData()
    }
}
