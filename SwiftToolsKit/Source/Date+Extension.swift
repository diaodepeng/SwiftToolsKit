//
//  Date+Expand.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation

extension Date: NamespaceWrappable { }
extension TypeWrapperProtocol where WrappedType == Date {
    
    // MARK: - Date转字符串
    /// Date转字符串
    ///
    /// - Parameter style: 时间格式
    /// - Returns: 转换之后的时间字符串
    public func toString(style: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = style
        
        return dateFormatter.string(from: wrappedValue)
    }
    
    // MARK: - 获取本地日期
    /// 获取本地日期(比服务器时间多出8个小时)
    ///
    /// - Returns: 本地日期
    public static func getNowLocalDate() -> Date {
        let date = Date()
        let zone: TimeZone = TimeZone.current
        let interval: Int = zone.secondsFromGMT(for: date)
        let localDate: Date = date.addingTimeInterval(TimeInterval(interval))
        
        return localDate
    } 
    
    // MARK: - 获取相对时间间隔描述
    /// 获取相对时间间隔描述
    ///
    /// - Parameter beforeTimeInterval: 某时刻的时间戳
    /// - Returns: 时间间隔描述 小于一分钟(刚刚) / 小于一小时(xx分钟前) / 大于1小时且小于24小时(xx小时前) / 小于48小时(昨天) / 大于48小时(MM-dd) / 本年内(MM-dd) / 非本年内(yy-MM-dd)
    public static func distanceTime(with before: TimeInterval, pastTwoDaysFormat: String = "MM-dd", thisYearFormat: String = "MM-dd", pastYearFormat: String = "yy-MM-dd") -> String {
        
        let beforeTimeInterval = before > 10000000000 ? before / 1000.0 : before
        let nowTimeInterval = Date().timeIntervalSince1970
        let distanceTimeInterval = nowTimeInterval - beforeTimeInterval
        
        // 小于1分钟
        if distanceTimeInterval < 60 * 3 { return "刚刚" }
        // 小于1小时
        if distanceTimeInterval < 60 * 60 { return String(format: "%.0f分钟前", floor(distanceTimeInterval / 60)) }
        
        let beforeDate = Date(timeIntervalSince1970: beforeTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let nowDate = Self.getNowLocalDate()
        let nowDay = dateFormatter.string(from: nowDate)
        let lastDay = dateFormatter.string(from: beforeDate)
        let nowDayInt = Int(nowDay)!
        let lastDayInt = Int(lastDay)!
        
        // 小于1天
        if distanceTimeInterval < 24 * 60 * 60 && nowDayInt == lastDayInt {
            
            let pastHours = (distanceTimeInterval - 3600.0) / 3600.0
            return String(format: "%.0lf小时前", pastHours)
        }
        
        if distanceTimeInterval < 24 * 60 * 60 * 2 && nowDayInt != lastDayInt {
            if nowDayInt - lastDayInt == 1 || (lastDayInt - nowDayInt > 10 && nowDayInt == 1) {
                return "昨天"
            } else {
                dateFormatter.dateFormat = pastTwoDaysFormat
                return dateFormatter.string(from: beforeDate)
            }
        }
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: beforeDate)
        let nowDateYearString = nowDate.st.toString(style: TimeFormatType.normal.rawValue).st[0..<4]
        // 本年内
        if yearString == nowDateYearString {
            dateFormatter.dateFormat = thisYearFormat
            return dateFormatter.string(from: beforeDate)
        } else { // 不是本年
            dateFormatter.dateFormat = pastYearFormat
            return dateFormatter.string(from: beforeDate)
        }
    }
}
