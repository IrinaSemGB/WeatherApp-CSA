//
//  DateTableViewCell.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 15.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionCellLabel: UILabel? {
        didSet {
            descriptionCellLabel?.text = "Today is"
            descriptionCellLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            descriptionCellLabel?.textColor = .white
        }
    }
    
    @IBOutlet private weak var calendarIcon: UIImageView? {
        didSet {
            calendarIcon?.image = UIImage(named: "calendarIcon")
            calendarIcon?.contentMode = .scaleToFill
        }
    }
    
    @IBOutlet private weak var dateLabel: UILabel? {
        didSet {
            dateLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
            dateLabel?.textColor = .white
            dateLabel?.shadowColor = .gray
            dateLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    public func setDate(forecast: [String : Any]) {
        
        var dateForSet = TimeInterval()
        if let date = forecast["date"] {
            dateForSet = date as! TimeInterval
        }
        self.dateLabel?.text = getDayForDate(Date(timeIntervalSince1970: Double(dateForSet)))
    }
    
    
    private func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, EEEE"
        return formatter.string(from: inputDate)
    }
}
