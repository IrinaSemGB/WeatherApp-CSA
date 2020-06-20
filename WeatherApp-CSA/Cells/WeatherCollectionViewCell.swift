//
//  WeatherCollectionViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 19.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel? {
        didSet {
            dateLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var weatherIcon: UIImageView?
    
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    
    func configure(whithWeather weather: Weather) {
        
        let date = Date(timeIntervalSince1970: weather.date)
        let stringDate = WeatherCollectionViewCell.dateFormatter.string(from: date)
        self.dateLabel?.text = stringDate
        
        self.weatherLabel?.text = String("\(weather.temp) C")
        
        self.weatherIcon?.image = UIImage(named: weather.weatherIcon)
    }
}
