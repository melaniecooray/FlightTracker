//
//  FavoritesViewController-tableView.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/6/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteList", for: indexPath) as! FavoriteCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.flightNum.text = favorites[indexPath[1]].airline + favorites[indexPath[1]].flightNumber
        let date = favorites[indexPath[1]].departureTime!
        let index = date.index(date.endIndex, offsetBy: -5)
        let index2 = date.index(date.endIndex, offsetBy: -7)
        let substring2 = date[index...]
        let substring1 = date[...index2]
        cell.flightTime.text = String(substring1 + "   " + substring2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFlight = favorites[indexPath[1]]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toFavoriteFlight", sender: self)
    }
}
