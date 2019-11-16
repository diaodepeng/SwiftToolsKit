//
//  UIColor+Extension.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

extension UIColor: STKNamespaceWrappable { }

extension STKTypeWrapperProtocol where STKWrappedType: UIColor {
    
    // MARK: - 获取随机颜色
    /// 获取颜色值 "#XXXXXX"
    public var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        stkWrappedValue.getRed(&r, green: &g, blue: &b, alpha: nil)
        return String.init(format: "#%02x%02x%02x", UInt8(r * 255), UInt8(g * 255), UInt8(b * 255))
    }
    
    // MARK: - 获取随机颜色
    /// 获取随机颜色
    public static var randomColor: UIColor {
        get {
            return UIColor(red: CGFloat(arc4random() % 255) / 255.0,
                           green: CGFloat(arc4random() % 255) / 255.0,
                           blue: CGFloat(arc4random() % 255) / 255.0,
                           alpha: 1.0)
        }
    }
    
    // MARK: - 获取随机颜色(深色)
    /// 获取随机颜色(深色)
    public static var randomColorDeep: UIColor {
        get {
            return UIColor(red: CGFloat(arc4random() % 100 + 55) / 255.0,
                           green: CGFloat(arc4random() % 100 + 55) / 255.0,
                           blue: CGFloat(arc4random() % 100 + 55) / 255.0,
                           alpha: 1.0)
        }
    }
    
    // MARK: - 获取随机颜色(浅色)
    /// 获取随机颜色(浅色)
    public static var randomColorLight: UIColor {
        get {
            return UIColor(red: CGFloat(arc4random() % 100 + 155) / 255.0,
                           green: CGFloat(arc4random() % 100 + 155) / 255.0,
                           blue: CGFloat(arc4random() % 100 + 155) / 255.0,
                           alpha: 1.0)
        }
    }
    
    // MARK: - RGB 颜色值便捷方法
    /// RGB 颜色值便捷构建
    ///
    /// - Parameters:
    ///   - red: 红
    ///   - green: 绿
    ///   - blue: 蓝
    ///   - alpha: 透明度
    /// - Returns: 颜色
    public static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /// 十六进制色值转换 Color 便捷方法
    ///
    /// - Parameters:
    ///   - hex: 十六进制数色值 或 十六进制字符串色值
    ///   - alpha: 透明度
    /// - Returns: 颜色
    public static func hexColor<T: Equatable> (hex: T, alpha: CGFloat = 1.0) -> UIColor {
        if T.self == String.self {
            return self.hexStringColor(hex: hex as! String, alpha: alpha)
        } else if T.self == Int.self {
            return self.hexIntColor(hexInt: hex as! Int, alpha: CGFloat(alpha))
        } else {
            return UIColor.black
        }
    }
    
    // MARK: - Private method
    
    /// 十六进制色值转换 Color
    ///
    /// - Parameters:
    ///   - hex: 十六进制字符串色值
    ///   - alpha: 透明度
    /// - Returns: 颜色
    private static func hexStringColor(hex: String, alpha: CGFloat) -> UIColor {
        var red: uint = 0, green: uint = 0, blue: uint = 0
        var prefixCount = 0
        
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            prefixCount = 2
        } else if hex.hasPrefix("#") {
            prefixCount = 1
        }
        
        func cutString(originString: String, prefix: Int, startOffset: Int, endOffset: Int) -> String {
            let start = originString.index(originString.startIndex, offsetBy: prefix + startOffset)
            let end = originString.index(originString.startIndex, offsetBy: prefix + endOffset)
            return String(originString[start...end])
        }
        
        let redStr = cutString(originString: hex, prefix: prefixCount, startOffset: 0, endOffset: 1)
        let greenStr = cutString(originString: hex, prefix: prefixCount, startOffset: 2, endOffset: 3)
        let blueStr = cutString(originString: hex, prefix: prefixCount, startOffset: 4, endOffset: 5)
        
        Scanner(string: redStr).scanHexInt32(&red)
        Scanner(string: greenStr).scanHexInt32(&green)
        Scanner(string: blueStr).scanHexInt32(&blue)
        
        return self.rgbColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
    
    /// 十六进制色值转换 Color
    ///
    /// - Parameters:
    ///   - hexInt: 十六进制数色值
    ///   - alpha: 透明度
    /// - Returns: 颜色
    private static func hexIntColor(hexInt: Int, alpha: CGFloat) -> UIColor {
        let r: CGFloat = ((CGFloat)((hexInt & 0xff0000) >> 16)) / 255.0
        let g: CGFloat = ((CGFloat)((hexInt & 0xff00) >> 8)) / 255.0
        let b: CGFloat = ((CGFloat)(hexInt & 0xff)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
}
