//
//  WeatherTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 08.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel?
    @IBOutlet weak var weatherImage: UIImageView? {
        didSet {
            weatherImage?.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var temperatureMaxLabel: UILabel? {
        didSet {
            temperatureMaxLabel?.textAlignment = .center
        }
    }
    @IBOutlet weak var temperatureMinLabel: UILabel? {
        didSet {
            temperatureMinLabel?.textAlignment = .center
        }
    }
    
//    static let dateFormatter: DateFormatter = {
//        let df = DateFormatter()
//        df.dateFormat = "dd.MM.yyyy HH.mm"
//        return df
//    }()
    
    
    func setWeather(weather: Weather) {
        
//        let date = Date(timeIntervalSince1970: weather.date)
//        let stringDate = WeatherTableViewCell.dateFormatter.string(from: date)
        
        self.dayLabel?.text = getDayForDate(Date(timeIntervalSince1970: Double(weather.date)))
        self.weatherImage?.image = UIImage(named: "\(weather.weatherName)")
        self.temperatureMaxLabel?.text = "\(Int(weather.tempMax))°"
        self.temperatureMinLabel?.text = "\(Int(weather.tempMin))°"
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, HH:mm"
        return formatter.string(from: inputDate)
    }
}
