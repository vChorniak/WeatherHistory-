//
//  Constant.swift
//  WeatherHistory
//
//  Created by user on 12/19/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Constant {
    
    static let baseURL = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/"
    static let dataType = "data.txt"
    
    static var stations = [Station(name: "Yeovilton", data: [StationData]()),
                           Station(name: "Wick Airport", internalTitle: "wickairport", data: [StationData]()),
                           Station(name: "Whitby", data: [StationData]()),
                           Station(name: "Waddington", data: [StationData]()),
                           Station(name: "Valley", data: [StationData]()),
                           Station(name: "Tiree", data: [StationData]()),
                           Station(name: "Sutton Bonington", internalTitle: "suttonbonington", data: [StationData]()),
                           Station(name: "Stornoway Airport", internalTitle: "stornoway", data: [StationData]()),
                           Station(name: "Southampton", data: [StationData]()),
                           Station(name: "Shawbury", data: [StationData]()),
                           Station(name: "Ross-on-Wye", internalTitle: "rossonwye", data: [StationData]()),
                           Station(name: "Ringway", data: [StationData]()),
                           Station(name: "Paisley", data: [StationData]()),
                           Station(name: "Oxford", data: [StationData]()),
                           Station(name: "Nairn", data: [StationData]()),
                           Station(name: "Manston",  data: [StationData]()),
                           Station(name: "Lowestoft", data: [StationData]()),
                           Station(name: "Leuchars", data: [StationData]()),
                           Station(name: "Lerwick", data: [StationData]()),
                           Station(name: "Hurn", data: [StationData]()),
                           Station(name: "Heathrow", data: [StationData]()),
                           Station(name: "Eskdalemuir", data: [StationData]()),
                           Station(name: "Eastbourne", data: [StationData]()),
                           Station(name: "Durham", data: [StationData]()),
                           Station(name: "Dunstaffnage", data: [StationData]()),
                           Station(name: "Cwmystwyth", data: [StationData]()),
                           Station(name: "Chivenor", data: [StationData]()),
                           Station(name: "Cardiff Bute Park", internalTitle: "cardiff", data: [StationData]()),
                           Station(name: "Cambridge NIAB", internalTitle: "cambridge", data: [StationData]()),
                           Station(name: "Camborne", data: [StationData]()),
                           Station(name: "Braemar", data: [StationData]()),
                           Station(name: "Bradford", data: [StationData]()),
                           Station(name: "Ballypatrick Forest", internalTitle: "ballypatrick", data: [StationData]()),
                           Station(name: "Armagh", data: [StationData]()),
                           Station(name: "Aberporth", data: [StationData]())]
    
    static func saveData(toStation savedStation: Station) {        
        for index in 0..<stations.count {
            if stations[index].name == savedStation.name {
                Constant.stations[index].data = savedStation.data
            }
        }
    }
}

