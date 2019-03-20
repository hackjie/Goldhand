//
//  Date+Helper.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2019/3/20.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

extension Date {
    /// Get current system date string --- 当前所在时区的准确时间
    ///
    /// - Parameter formatter: String
    /// - Returns: String
    static func currentDateString(_ formatter: String = "yyyy-MM-dd") -> String {
        let date = Date()
        return date.dateToString(formatter)
    }
    
    /// Format Date to String --- 日期格式化字符串
    ///
    /// - Parameter formatter: String
    /// - Returns: String
    func dateToString(_ formatter: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
    
    /// Get Date from string --- 字符串格式化日期
    ///
    /// - Parameters:
    ///   - string: String
    ///   - formatter: String
    /// - Returns: Date?
    static func dateFromString(_ string: String,
                               formatter: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: string)
    }
    
    /// Get current system date --- 获取当前系统所在时区的 Date
    /// do not use it to format string --- 不要用这个时间去转化成字符串，DateFormatter 会自动跟据
    /// 设置时区转（默认根据系统所在时区自动转，尽量使用字符串时间做交互
    ///
    /// - Returns: Date
    static func currentZoneDate() -> Date {
        let date = Date()
        let zone = TimeZone.current
        let interval: NSInteger = zone.secondsFromGMT(for: date)
        let currentDate = date.addingTimeInterval(TimeInterval(interval))
        return currentDate
    }
    
    /// Get year of date --- 日期所在年
    ///
    /// - Returns: Int
    func year() -> Int {
        let calendar = Calendar.current
        let component = calendar.component(.year, from: Date())
        return component
    }
    
    /// Get month of date --- 日期所在月
    ///
    /// - Returns: Int
    func month() -> Int {
        let calendar = Calendar.current
        let component = calendar.component(.month, from: Date())
        return component
    }
    
    /// Get day of date --- 日期所在天
    ///
    /// - Returns: Int
    func day() -> Int {
        let calendar = Calendar.current
        let component = calendar.component(.day, from: Date())
        return component
    }
    
    /// Get num of days at special year and month --- 获取特定年月的天数
    ///
    /// - Parameters:
    ///   - year: Int
    ///   - month: Int
    /// - Returns: Int
    func getCountOfDaysInYear(_ year: Int,
                              month: Int) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: String(year)+"-"+String(month))
        if let date = date {
            let calendar = Calendar.current
            let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
            if let range = range {
                return range.length
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
}
