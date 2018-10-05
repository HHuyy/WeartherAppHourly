//
//  DataService.swift
//  WeartherAppHourly
//
//  Created by Đừng xóa on 7/30/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation
typealias DICT = Dictionary<AnyHashable,Any>

class DataService {
    static var shared: DataService = DataService()
    
    func getWeatherForecast(completedHandler: @escaping(WeatherForecast) -> Void) {
        let url = "https://api.apixu.com/v1/forecast.json?key=7ef0663d09174c43b9d12527181807&q=HaNoi&days=7"
        guard let urlString = URL(string: url) else {return}
        let urlRequest = URLRequest(url: urlString)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                if let jSonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                    DispatchQueue.main.async {
                        completedHandler(WeatherForecast(dictionary: jSonObject))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        downloadTask.resume()
    }
    
    func getCurrentForecast(completedHandler: @escaping(CurrentForecast) -> Void) {
        let url = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=3b5667b7701e4af4a3275037182407&q=Ha+Noi&num_of_days=1&tp=1&format=json"
        guard let urlString = URL(string: url) else {return}
        let urlRequest = URLRequest(url: urlString)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                if let jSonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                    DispatchQueue.main.async {
                        completedHandler(CurrentForecast(dictionary: jSonObject))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        downloadTask.resume()
    }
}


