//
//  CurrentForecast.swift
//  WeartherAppHourly
//
//  Created by Đừng xóa on 7/31/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

class CurrentForecast {
    var currentDay: [Hourly] = []
    
    init(dictionary: DICT) {
        let data = dictionary["data"] as? DICT ?? [:]
        let weather = data["weather"] as? [DICT] ?? []
        let zero = weather[0]
        let hourly = zero["hourly"] as? [DICT] ?? []
        for hourlyData in hourly {
            self.currentDay.append(Hourly(dict: hourlyData))
        }
    }
}

struct Hourly {
    var time: String?
    var tempC: String?
    var value: String?
    
    init(dict: DICT) {
        time = dict["time"] as? String ?? "-999"
        tempC = dict["tempC"] as? String ?? "-9999"
        let weatherIconUrl = dict["weatherIconUrl"] as? [DICT] ?? []
        let zero = weatherIconUrl[0]
        value = zero["value"] as? String ?? "-9999"
    }
}
