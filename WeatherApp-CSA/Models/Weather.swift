//
//  Weather.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 16.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseFirestore


class Weather {
    
    var date = 0.0
    var temp = 0
    var tempMin = 0.0
    var tempMax = 0.0
    var weatherName = ""
    var weatherIcon = ""
    var weatherDescription = ""
    var pressure = 0
    var humidity = 0
    var windSpeed = 0.0
    var cloudiness = 0
    var city = ""
    
    
    convenience init(json: JSON) {
            self.init()
        
        self.date = json["dt"].doubleValue
        self.temp = json["main"]["temp"].intValue
        self.tempMin = json["main"]["temp_min"].doubleValue
        self.tempMax = json["main"]["temp_max"].doubleValue
        self.weatherName = json["weather"][0]["main"].stringValue
        self.weatherIcon = json["weather"][0]["icon"].stringValue
        self.weatherDescription = json["weather"][0]["description"].stringValue
        self.pressure = json["main"]["pressure"].intValue
        self.humidity = json["main"]["humidity"].intValue
        self.windSpeed = json["wind"]["speed"].doubleValue
        self.cloudiness = json["clouds"]["all"].intValue
        self.city = city
    }
    
    func toFirestore() -> [String : Any] {
        return [
            "date" : date,
            "temp" : temp,
            "tempMin" : tempMin,
            "tempMax" : tempMax,
            "weatherName" : weatherName,
            "weatherIcon" : weatherIcon,
            "weatherDescription" : weatherDescription,
            "pressure" : pressure,
            "humidity" : humidity,
            "windSpeed" : windSpeed,
            "cloudiness" : cloudiness,
            "city" : city
        ]
    }
}

class WeatherResponse {
    let list: [Weather] = []
}

