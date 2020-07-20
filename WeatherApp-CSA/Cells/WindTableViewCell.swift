//
//  WindTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 16.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class WindTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.text = "Wind speed"
            descriptionLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            descriptionLabel?.textColor = .white
            descriptionLabel?.shadowColor = .gray
        }
    }
    @IBOutlet private weak var windLabel: UILabel? {
        didSet {
            windLabel?.contentMode = .right
            windLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
            windLabel?.textColor = .white
            windLabel?.shadowColor = .white
        }
    }
    
    
    public func setWind(forecast: [String : Any]) {
        
        var windLabelText = String()
        if let wind = forecast["windSpeed"] {
            windLabelText = "\(wind as! Double)" + " m/s"
        }
        self.windLabel?.text = windLabelText
    }
}
