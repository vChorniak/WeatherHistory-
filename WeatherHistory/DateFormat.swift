//
//  DateFormat.swift
//  WeatherHistory
//
//  Created by user on 12/18/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

class DateFormat {
    static func dateFormatter(time: String) -> String {
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "MM"
        guard let date = dateFormatter.date(from: time) else { return "-" }
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
