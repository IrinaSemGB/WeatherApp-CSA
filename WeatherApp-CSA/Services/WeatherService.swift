//
//  WeatherService.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 15.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    func loadWeatherData(city: String, comletion: @escaping ([Weather]) -> Void) {
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
                    
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            
            comletion(weather)
        }
    }
}
// http://api.openweathermap.org/data/2.5/forecast?q=Moscow&units=metric&appid=92cabe9523da26194b02974bfcd50b7e
