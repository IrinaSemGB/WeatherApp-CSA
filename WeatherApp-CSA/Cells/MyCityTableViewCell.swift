//
//  MyCityTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 04.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class MyCityTableViewCell: UITableViewCell {

    @IBOutlet weak var myCityNameLabel: UILabel? {
        didSet {
            myCityNameLabel?.textColor = .white
            myCityNameLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        }
    }

    
    func setWeatherInMyCity(city: City) {
        
        self.myCityNameLabel?.text = city.name
    }
}
