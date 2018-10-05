//
//  WeatherForecast.swift
//  WeartherAppHourly
//
//  Created by Đừng xóa on 7/26/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

class WeatherForecast {
    var forecastday: [WeatherDay] = []
    var name: String?
    var temp_c: Double?
    var localtime_epoch: TimeInterval?
    var text: String?
    var last_updated_epoch: TimeInterval?
    
    
    
    init(dictionary: DICT) {
        let location = dictionary["location"] as? DICT ?? [:]
        name = location["name"] as? String ?? "-9999"
        localtime_epoch = location["localtime_epoch"] as? TimeInterval ?? -9999
        let current = dictionary["current"] as? DICT ?? [:]
        temp_c = current["temp_c"] as? Double ?? -9999
        last_updated_epoch = current["last_updated_epoch"] as? TimeInterval ?? -9999
        let condition = current["condition"] as? DICT ?? [:]
        text = condition["text"] as? String ?? "-9999"
        let forecast = dictionary["forecast"] as? DICT ?? [:]
        let forecastday = forecast["forecastday"] as? [DICT] ?? []
        for weatherDay in forecastday {
            self.forecastday.append(WeatherDay(dict: weatherDay))
        }
    }
    
    
}

struct WeatherDay {
    var date: String
    var date_epoch: TimeInterval
    var mintemp_c: Double
    var maxtemp_c: Double
    var condition: Condition
    
    init(dict: DICT) {
        date = dict["date"] as? String ?? "-9999"
        date_epoch = dict["date_epoch"] as? TimeInterval ?? -9999
        let day = dict["day"] as? DICT ?? [:]
        mintemp_c = day["mintemp_c"] as? Double ?? -9999
        maxtemp_c = day["maxtemp_c"] as? Double ?? -9999
        condition = Condition(dict: day["condition"] as? DICT ?? [:])
    }
}

struct Condition {
    var icon: String
    
    init(dict: DICT) {
        icon = "http:" + (dict["icon"] as? String ?? "-9999")
    }
}
