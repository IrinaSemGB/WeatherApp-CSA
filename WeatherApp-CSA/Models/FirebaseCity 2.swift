//
//  FirebaseCity.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 14.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseCity {
    
    let name: String
    let zipcode: Int
    let reference: DatabaseReference?
    
    init(name: String, zipcode: Int) {
        self.name = name
        self.zipcode = zipcode
        self.reference = nil
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let value = snapshot.value as? [String : Any],
            
            let zipcode = value["zipcode"] as? Int,
            
            let name = value["name"] as? String else {
                return nil
        }
        
        self.reference = snapshot.ref
        self.zipcode = zipcode
        self.name = name
    }

    func toAnyObject() -> [String : Any] {
        return [
            "name" : name,
            "zipcode" : zipcode
        ]
    }
}
