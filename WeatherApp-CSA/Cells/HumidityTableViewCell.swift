//
//  HumidityTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 16.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class HumidityTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.text = "Humidity"
            descriptionLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            descriptionLabel?.textColor = .white
            descriptionLabel?.shadowColor = .gray
        }
    }
    @IBOutlet private weak var humidityLabel: UILabel? {
        didSet {
            humidityLabel?.contentMode = .right
            humidityLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
            humidityLabel?.textColor = .white
            humidityLabel?.shadowColor = .white
        }
    }
    
    public func setHumidity(forecast: [String : Any]) {
        
        var humidityLabelText = String()
        if let humidity = forecast["humidity"] {
            humidityLabelText = "\(humidity as! Int)" + "%"
        }
        self.humidityLabel?.text = humidityLabelText
    }
}
