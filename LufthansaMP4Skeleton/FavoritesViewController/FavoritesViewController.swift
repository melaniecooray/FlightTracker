//
//  FavoritesViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var tableView: UITableView!
    var favorites: [Flight] = []
    
    var noFavoritesLabel: UILabel!
    
    var selectedFlight: Flight!
    
    var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //displayList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        loadFavorites()
    }
    
    func displayTitle() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: 100)
        titleLabel.text = "Favorite Flights"
        titleLabel.font = UIFont(name: "Avenir-Light", size: 50)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    func displayList() {
        tableView = UITableView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height - 200))
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteList")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func loadFavorites() {
        favorites = []
        var num = UserDefaults.standard.integer(forKey: "favoritesCount")
        noFavoritesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        noFavoritesLabel.text = "No Favorites"
        noFavoritesLabel.textAlignment = .center
        noFavoritesLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        view.addSubview(noFavoritesLabel)
        if num == 0 {
            noFavoritesLabel.text = "No Favorites"
        } else {
            noFavoritesLabel.text = "Loading..."
        }
        while num > 0 {
            let num1 = num - 1
            let num2 = num - 2
            let flightNumber = UserDefaults.standard.string(forKey: "\(num2)")
            //print(flightNumber)
            let datte = UserDefaults.standard.string(forKey: "\(num1)")
            print(datte)
            LufthansaAPIClient.getAuthToken {
                LufthansaAPIClient.getFlightStatus(flightNum: flightNumber!, date: datte!) { flt in
                    LufthansaAPIClient.getAircraft(type: flt.aircraft) { air in
                        LufthansaAPIClient.getAirport(airportCode: flt.originAirport) { origin in
                            LufthansaAPIClient.getAirport(airportCode: flt.destinationAirport) { dest in
                                flt.aircraftObject = air
                                flt.originAirportObject = origin
                                flt.destinationAirportObject = dest
                                self.favorites.append(flt)
                                if num - 2 <= 0 {
                                    self.displayTitle()
                                    self.displayList()
                                }
                            }
                        }
                    }
                }
            }
            num = num - 2
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? FlightInformationViewController {
            resultVC.flight = selectedFlight
        }
    }

}
