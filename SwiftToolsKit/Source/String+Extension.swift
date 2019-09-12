//
//  String+Expand.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

extension String: NamespaceWrappable { }
extension TypeWrapperProtocol where WrappedType == String {
    
    // MARK: - 时间戳转时间字符串
    /// 时间戳转时间字符串
    ///
    /// - Parameters:
    ///   - timeInterval: 时间戳
    ///   - format: 转换的时间格式
    /// - Returns: 转换完成之后的时间字符串
    public static func timeString(timeInterval: TimeInterval, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = format
        
        // 秒格式10位, 毫秒格式13位
        let interval = timeInterval > 10000000000 ? timeInterval * 0.001 : timeInterval
        return dateFormatter.string(from: Date(timeIntervalSince1970: interval))
    }
    
    /// 字符串转时间Date
    ///
    /// - Parameter style: 时间格式
    /// - Returns: Date？
    public func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.locale = Locale.init(identifier: "en_US")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: wrappedValue)
    }
    
    // MARK: - 中文转小写拼音(不带音标)
    /// 中文转小写拼音(不带音标)
    ///
    /// - Returns: 拼音
    public func toPinyin() -> String {
        guard !wrappedValue.isEmpty, !wrappedValue.isEmpty else { return "" }
        
        // 把汉字转为拼音, 去掉拼音的音标
        let mutableString = NSMutableString(string: wrappedValue)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        return String(mutableString)
    }
    
    // MARK: - 拼音获取大写首字母
    /// 拼音获取大写首字母
    ///
    /// - Returns: 大写字母
    public func firstLetterUpper() -> String {
        guard !wrappedValue.isEmpty else { return "#" }
        
        let upperStr = wrappedValue.uppercased()
        return (upperStr.st[0..<1] >= "A" && upperStr.st[0..<1] <= "Z") ? upperStr.st[0..<1] : "#"
    }
    
    // MARK: - 获取文本高度
    /// 获取文本高度
    ///
    /// - Parameters:
    ///   - width: 给定宽度
    ///   - font: 字号
    /// - Returns: 测算高度
    public func getStringHeight(byWidth width: Float, attributes: [NSAttributedString.Key : Any]? = nil) -> CGFloat {
        let rect: CGRect = wrappedValue.boundingRect(with: CGSize(width: Double(width), height: Double(MAXFLOAT)),
                                                     options: [.usesLineFragmentOrigin],
                                                     attributes: attributes,
                                                     context: nil)
        
        return rect.height
    }
    
    // MARK: - 获取文本宽度
    /// 获取文本宽度
    ///
    /// - Parameters:
    ///   - height: 给定高度
    ///   - font: 字号
    /// - Returns: 测算宽度
    public func getStringWidth(byHeight height: CGFloat, attributes: [NSAttributedString.Key : Any]? = nil) -> CGFloat {
        let rect: CGRect = wrappedValue.boundingRect(with: CGSize(width: Double(MAXFLOAT), height: Double(height)),
                                                     options: [.usesLineFragmentOrigin],
                                                     attributes: attributes,
                                                     context: nil)
        
        return rect.width
    }
    
    // MARK: - 获取字符串尺寸
    /// 获取字符串尺寸
    ///
    /// - Parameters:
    ///   - str: 要测算的字符串
    ///   - font: 字号
    ///   - maxWidth: 最大宽度
    /// - Returns: 测算宽高
    public func getStringSize(withMaxWidth maxWidth: CGFloat, attributes: [NSAttributedString.Key : Any]? = nil) -> CGSize {
        let size = wrappedValue.boundingRect(with: CGSize(width: maxWidth,height: 0),
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             attributes: attributes,
                                             context: nil).size
        
        return size
    }
    
    // MARK: - 通过下标Range截取字符串
    /// 通过下标Range截取字符串
    ///
    /// - Parameter r: 截取范围
    public subscript (r: Range<Int>) -> String {
        get {
            let startIndex = wrappedValue.index(wrappedValue.startIndex, offsetBy: r.lowerBound)
            let endIndex = wrappedValue.index(wrappedValue.startIndex, offsetBy: r.upperBound)
            return String(wrappedValue[startIndex..<endIndex])
        }
    }
}
