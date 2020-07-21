//
//  PressureTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 15.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class PressureTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.text = "Atmosphere pressure"
            descriptionLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            descriptionLabel?.textColor = .white
            descriptionLabel?.shadowColor = .gray
        }
    }
    @IBOutlet private weak var pressureLabel: UILabel? {
        didSet {
            pressureLabel?.contentMode = .right
            pressureLabel?.font = UIFont(name: "Helvetica-Bold", size: 19)
            pressureLabel?.textColor = .lightText
            pressureLabel?.shadowColor = .white
        }
    }

    
    public func setPressure(forecast: [String : Any]) {
        
        var pressureLabelText = String()
        var pressureMM = Int()
        if let pressure = forecast["pressure"] {
            pressureMM = pressure as! Int / 133 * 100
            pressureLabelText = "\(pressureMM) mm"
        }
        self.pressureLabel?.text = pressureLabelText
    }
}
