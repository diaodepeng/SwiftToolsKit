//
//  Date+Expand.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation

extension Date: NamespaceWrappable {}
extension TypeWrapperProtocol where WrappedType == Date {
    
    // MARK: - Date 转字符串
    /// Date 转字符串
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
    /// 获取本地日期(比服务器时间多出 8 个小时)
    ///
    /// - Returns: 本地日期
    public static func getNowLocalDate() -> Date {
        let date = Date()
        let zone: TimeZone = TimeZone.current
        let interval: Int = zone.secondsFromGMT(for: date)
        let localDate: Date = date.addingTimeInterval(TimeInterval(interval))
        return localDate
    }
    
}
