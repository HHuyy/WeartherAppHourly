//
//  Extension TimeInterval.swift
//  WeartherAppHourly
//
//  Created by Đừng xóa on 8/1/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

extension TimeInterval {
    var toString: String {
        get {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "EEEE d/MM"
            dateFormater.locale = Locale(identifier: "vi_VN")
            let date = Date(timeIntervalSince1970: self)
            return dateFormater.string(from: date)
        }
    }
    
    var toNow: String {
        get {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "H"
            dateFormater.locale = Locale(identifier: "vi_VN")
            let date = Date(timeIntervalSince1970: self)
            return dateFormater.string(from: date)
        }
    }
    
}

