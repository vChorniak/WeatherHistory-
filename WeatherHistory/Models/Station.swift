//
//  Station.swift
//  WeatherHistory
//
//  Created by user on 12/19/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Station {
    var name: String
    var internalTitle: String
    var data: [StationData]
    
    init(name: String, internalTitle: String? = nil, data: [StationData] = []) {
        self.name = name
        self.internalTitle = internalTitle ?? name.lowercased()
        self.data = data
    }
}
