//
//  WeatherService.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 15.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FirebaseFirestore


class WeatherService {
    
    private let baseUrl = "http://api.openweathermap.org"
    private let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    
    public func loadWeatherData(city: String) {
        
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
                self.saveToFirestore(weather, city: city)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func saveToFirestore(_ weathers: [Weather], city: String) {
        
        let database = Firestore.firestore()
        
        let weathersToSend = weathers
            .map { $0.toFirestore() }
            .reduce([:]) { $0.merging($1) { (current, _) in current } }
        
        database.collection("forecasts").document(city).setData(weathersToSend, merge: true) { error in
        if let error = error {
            print(error.localizedDescription)
            } else { print("data saved")}
        }
    }
}

