//
//  WeatherService.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 15.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON


class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    
    func loadWeatherData(city: String) {
        
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        
        let url = baseUrl + path
            
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let weather = json["list"].arrayValue.map { Weather(json: $0) }
                weather.forEach { $0.city = city }
                self.saveWeatherData(weather, city: city)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func saveWeatherData(_ weathers: [Weather], city: String) {
        
        do {
        
            let realm = try Realm()
            guard let city = realm.object(ofType: City.self, forPrimaryKey: city) else { return }
            let oldWeathers = city.weathers
            realm.beginWrite()
            realm.delete(oldWeathers)
            city.weathers.append(objectsIn: weathers)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}

