//
//  WeatherTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 08.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            descriptionLabel?.textColor = .white
        }
    }
    
    @IBOutlet private weak var weatherImage: UIImageView? {
        didSet {
            weatherImage?.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet private weak var temperatureMaxLabel: UILabel? {
        didSet {
            temperatureMaxLabel?.textAlignment = .center
            temperatureMaxLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
            temperatureMaxLabel?.textColor = .white
            temperatureMaxLabel?.shadowColor = .gray
        }
    }
    @IBOutlet private weak var temperatureMinLabel: UILabel? {
        didSet {
            temperatureMinLabel?.textAlignment = .center
            temperatureMinLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
            temperatureMinLabel?.textColor = .lightText
            temperatureMinLabel?.shadowColor = .gray
        }
    }
    
    
    public func setWeather(forecast: [String : Any]) {
        
        var description = String()
        if let weatherName = forecast["weatherName"] {
            description = "\(weatherName)"
        }
        self.descriptionLabel?.text = "It's \(description)"
        self.weatherImage?.image = UIImage(named: description)
        
        var tempMaxText = String()
        var tempMinText = String()
        var tempMaxValue = Double()
        var tempMinValue = Double()
        
        if let tempMax = forecast["tempMax"], let tempMin = forecast["tempMin"] {
            
            tempMaxValue = tempMax as! Double
            tempMinValue = tempMin as! Double
            
            tempMaxText = String(format: "%0.f", tempMaxValue) + "°"
            tempMinText = String(format: "%0.f", tempMinValue) + "°"
        }
        self.temperatureMaxLabel?.text = tempMaxText
        self.temperatureMinLabel?.text = tempMinText
    }
}
