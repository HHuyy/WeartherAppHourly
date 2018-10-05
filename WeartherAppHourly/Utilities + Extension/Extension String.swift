//
//  Extension String.swift
//  WeartherAppHourly
//
//  Created by Đừng xóa on 8/1/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

extension String {
    func toHour() -> Int {
        guard let numbe = Int(self) else { return 10000 }
        return numbe / 100
    }
    func toInt() -> Int {
        guard let number = Int(self) else { return 999 }
        return number
    }
}

