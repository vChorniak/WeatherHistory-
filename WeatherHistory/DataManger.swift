//
//  DataManger.swift
//  WeatherHistory
//
//  Created by user on 12/18/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

class DataManager {
    
    func readData(forStation station: String, complition: @escaping ((_ data: [StationData]) -> Void), failure: @escaping (_ error: NSError) -> Void) {
        let fileURL = URL(string: Constant.baseURL + station + Constant.dataType)
        
        guard let urlString = fileURL else { return }
        do {
            let fullText = try String(contentsOf: urlString)
            let readings = fullText.components(separatedBy: "\n") as [String]
            let stationData = parseModel(models: readings)
            complition(stationData)
        } catch let error as NSError {
            print("Error loading: \(error)")
            failure(error)
        }
    }
    
    func parseModel(models: [String]) -> [StationData] {
        var stationDataArray = [StationData]()
        for data in 7..<models.count {
            let dataArray = componentString(string: models[data])
            
            switch dataArray.count {
            case 6...8:
                let stationData = StationData.init(year: dataArray[0], month: dataArray[1], maxTemparature: dataArray[2], minTemparature: dataArray[3], rainDays: dataArray[4], rainMm: dataArray[5], sunHours: dataArray.indices.contains(6) ? dataArray[6] : nil)
                stationDataArray.append(stationData)
            default:
                continue
            }
        }
        return stationDataArray
    }
    
    func componentString(string: String) -> [String] {
        var dataArray = [String]()
        var data = ""
        for char in "\(string) " {
            if char != " ", char != "\r" {
                data += String(char)
            } else {
                if data != "" {
                    dataArray.append(data)
                    data = ""
                }
            }
        }
        return dataArray
    }
}
