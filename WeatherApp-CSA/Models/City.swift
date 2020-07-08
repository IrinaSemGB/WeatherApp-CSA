//
//  City.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 04.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import RealmSwift


class City: Object {
    
    @objc dynamic var name = ""
    let weathers = List<Weather>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
