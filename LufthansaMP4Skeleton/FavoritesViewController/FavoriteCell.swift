//
//  FavoriteCell.swift
//  LufthansaMP4Skeleton
//
//  Created by Melanie Cooray on 3/6/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FavoriteCell : UITableViewCell {
    
    var flightNum : UILabel!
    var flightTime : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flightNum = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: contentView.frame.height))
        flightNum.center = CGPoint(x: 75, y: contentView.frame.height/2)
        flightNum.font = UIFont(name: "Avenir-Light", size: 15)
        contentView.addSubview(flightNum)
        
        flightTime = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: contentView.frame.height))
        flightTime.center = CGPoint(x: 400, y: contentView.frame.height/2)
        flightTime.font = UIFont(name: "Avenir-Light", size: 15)
        contentView.addSubview(flightTime)
    }
    
}
