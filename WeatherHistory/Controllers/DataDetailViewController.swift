//
//  DataDetailViewController.swift
//  WeatherHistory
//
//  Created by user on 12/18/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class DataDetailViewController: UIViewController {
    
    let dateFormat = DateFormat()
    
    var dataArray: StationData?
    var stationName = ""

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTemparatureLabel: UILabel!
    @IBOutlet weak var minTemparatureLabel: UILabel!
    @IBOutlet weak var daysOfFrostLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    @IBOutlet weak var sunDuration: UILabel!
    
    var sunHours: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLabel()
    }
    
    func initLabel() {
        
        guard let station = dataArray else { return}
        
        stationNameLabel.text = stationName
        dateLabel.text = DateFormat.dateFormatter(time: station.month) + " " + station.year
        maxTemparatureLabel.text = station.maxTemparature + " C◦"
        minTemparatureLabel.text = station.minTemparature + " C◦"
        daysOfFrostLabel.text = station.rainDays + " days"
        rainfallLabel.text = station.rainMm + " mm"
        if let sunHour = dataArray?.sunHours {
            sunDuration.text = sunHour + " hours"
        } else {
            sunDuration.text = "-"
        }
    }
}
