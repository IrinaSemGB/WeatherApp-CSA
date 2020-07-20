//
//  MyCityTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 04.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class MyCityTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var myCityNameLabel: UILabel? {
        didSet {
            myCityNameLabel?.textColor = .white
            myCityNameLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        }
    }

    
    public func setWeatherInMyCity(city: FirebaseCity) {
        self.myCityNameLabel?.text = city.name
    }
}
