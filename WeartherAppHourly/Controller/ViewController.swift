//
//  ViewController.swift
//  WeartherAppHourly
//
//  Created by Đừng xóa on 7/25/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headNameLabel: UILabel!
    @IBOutlet weak var headTempLabel: UILabel!
    @IBOutlet weak var bottomDateLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    
    var forecastDay: [WeatherDay] = []
    var currentDay: [Hourly] = []
    var dispatchWorkItem: DispatchWorkItem?
    var timeNow: Int?
    var hourlyArray: [Hourly] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func getData() {
        DataService.shared.getWeatherForecast { (weather) in
            self.headNameLabel.text = weather.name
            self.headTempLabel.text = "\(weather.temp_c!)º"
            self.bottomDateLabel.text = "Today " + (weather.localtime_epoch?.toString)!
            self.bottomTextLabel.text = weather.text
            self.timeNow = Int((weather.last_updated_epoch?.toNow)!)
        
            self.forecastDay = weather.forecastday
            self.tableView.reloadData()
        }
        DataService.shared.getCurrentForecast { (weather) in
            self.currentDay = weather.currentDay
            self.collectionView.reloadData()
        }
    }
    
    func downloadImageInCell(at indexPath: IndexPath, with urlString: String) {
        guard let url = URL(string: urlString) else {return}
        DispatchQueue.global().async {
            if let data = try?  Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let cell = self.tableView.cellForRow(at: indexPath) as? TableViewCell {
                        cell.iconImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDay.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.dateLabel.text = forecastDay[indexPath.row + 1].date_epoch.toString
        cell.tempLabel.text = "\(forecastDay[indexPath.row + 1].mintemp_c)º-\(forecastDay[indexPath.row + 1].maxtemp_c)º"
        downloadImageInCell(at: indexPath, with: forecastDay[indexPath.row + 1].condition.icon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDay.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCellNow", for: indexPath) as! CollectionViewCellNow
        
            cell.tempLabel.text = "\(String(describing: currentDay[indexPath.row + 1].tempC ?? ""))º"
            cell.timeLabel.text = String(describing: currentDay[indexPath.row + 1].time?.toHour() ?? 0)
        
//        if indexPath.row + 1 == timeNow {
//            cell.tempLabel.text = "\(String(describing: currentDay[indexPath.row].tempC ?? ""))º"
//            cell.timeLabel.text = "Now"
//            print(timeNow)
//        } else {
//            cell.tempLabel.text = "\(String(describing: currentDay[indexPath.row + 1].tempC ?? ""))º"
//            cell.timeLabel.text = String(describing: currentDay[indexPath.row + 1].time?.toHour() ?? 0)
//        }
        return cell
    }
}

//Mark: - TableView
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return forecastDay.count - 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
//        cell.dateLabel.text = forecastDay[indexPath.row + 1].date_epoch.toString
//        cell.tempLabel.text = "\(forecastDay[indexPath.row + 1].mintemp_c)º-\(forecastDay[indexPath.row + 1].maxtemp_c)º"
//        downloadImageInCell(at: indexPath, with: forecastDay[indexPath.row + 1].condition.icon)
//        return cell
//    }
//}

//// Mark: CollectionView
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return currentDay.count - 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCellNow", for: indexPath) as! CollectionViewCellNow
////        var hourlyArray: [Hourly] = []
////        if indexPath.row == 0 {
////            cell.tempLabel.text = "\(String(describing: currentDay[indexPath.row].tempC ?? ""))º"
////            cell.timeLabel.text = "Now"
////        } else {
////            if indexPath.row + 1 == timeNow {
////                <#code#>
////            }
////        }
//
//        if indexPath.row + 1 == timeNow {
//            cell.tempLabel.text = "\(String(describing: currentDay[indexPath.row].tempC ?? ""))º"
//            cell.timeLabel.text = "Now"
//        } else {
//            cell.tempLabel.text = "\(String(describing: currentDay[indexPath.row + 1].tempC ?? ""))º"
//            cell.timeLabel.text = String(describing: currentDay[indexPath.row + 1].time?.toHour() ?? 0)
//        }
//
//
//        return cell
//    }
//}

