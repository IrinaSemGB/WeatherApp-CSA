//
//  Weather.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 16.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class Weather: Object {
    
     @objc dynamic var date = 0.0
     @objc dynamic var temp = 0
     @objc dynamic var tempMin = 0.0
     @objc dynamic var tempMax = 0.0
     @objc dynamic var weatherName = ""
     @objc dynamic var weatherIcon = ""
     @objc dynamic var windSpeed = 0.0
     @objc dynamic var city = ""
    
    
    convenience init(json: JSON) {
            self.init()
        
        self.date = json["dt"].doubleValue
        self.temp = json["main"]["temp"].intValue
        self.tempMin = json["main"]["temp_min"].doubleValue
        self.tempMax = json["main"]["temp_max"].doubleValue
        self.weatherName = json["weather"][0]["main"].stringValue
        self.weatherIcon = json["weather"][0]["icon"].stringValue
        self.windSpeed = json["wind"]["speed"].doubleValue
        self.city = city
    }
}

class WeatherResponse {
    let list: [Weather] = []
}

