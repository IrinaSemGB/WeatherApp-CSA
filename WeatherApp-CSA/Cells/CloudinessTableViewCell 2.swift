//
//  CloudinessTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 16.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class CloudinessTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.text = "Cloudiness"
            descriptionLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            descriptionLabel?.textColor = .white
            descriptionLabel?.shadowColor = .gray
        }
    }
    
    @IBOutlet private  weak var cloudnessLabel: UILabel? {
        didSet {
            cloudnessLabel?.contentMode = .right
            cloudnessLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
            cloudnessLabel?.textColor = .white
            cloudnessLabel?.shadowColor = .white
        }
    }
        
    
     public func setCloudness(forecast: [String : Any]) {
        
        var cloudinessLabelText = String()
        if let cloudiness = forecast["cloudiness"] {
            cloudinessLabelText = "\(cloudiness as! Int)" + "%"
        }
        self.cloudnessLabel?.text = cloudinessLabelText
    }
}
