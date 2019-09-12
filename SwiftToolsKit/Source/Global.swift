//
//  Global.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit
import Darwin

/// 获取当前APP的Version版本号
///
/// - Returns: APP的Version版本号
public func APP_VERSION() -> String {
    let infoDictionary = Bundle.main.infoDictionary!
    return infoDictionary["CFBundleShortVersionString"] as! String
    
}

/// 获取当前APP的Build版本号
///
/// - Returns: APP的Build版本号
public func APP_BUILD() -> String {
    let infoDictionary = Bundle.main.infoDictionary!
    return infoDictionary["CFBundleVersion"] as! String
}

/// 获取iOS系统版本
///
/// - Returns: 系统版本
public func SYSTEM_VERSION() -> String {
    return UIDevice.current.systemName + UIDevice.current.systemVersion
}

/// 验证手机号是否合法
///
/// - Parameter number: 手机号
/// - Returns: 验证结果
public func isMobileNumber(number: String) -> Bool {
    /**
     * 手机号码:
     * 移动号段: 134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、198
     * 联通号段: 130、131、132、145、155、156、166、175、176、185、186
     * 电信号段: 133、149、153、173、177、180、181、189、199
     * 14号段为以前为上网卡专属号段
     * 虚拟运营商电信：1700、1701、1702
     * 虚拟运营商移动：1703、1705、1706
     * 虚拟运营商联通：1704、1707、1708、1709、171
     * 卫星通信：1349
     */
    let mobile = #"^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(166)|(17[0-3]|[5-8])|(18[0-9])|(19[8|9]))\d{8}$"#
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    
    if regextestmobile.evaluate(with: number) == true {
        return true
    } else {
        return false
    }
}

/// 获取机型 (附：完整机型对照表https://www.theiphonewiki.com/wiki/Models)
///
/// - Returns: 机型
public func IPHONE_MODEL() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else {
            return identifier
        }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
        
    // iPhone
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":
        return "iPhone 4"
        
    case "iPhone4,1":
        return "iPhone 4s"
        
    case "iPhone5,1", "iPhone5,2":
        return "iPhone 5"
        
    case "iPhone5,3", "iPhone5,4":
        return "iPhone 5C"
        
    case "iPhone6,1", "iPhone6,2":
        return "iPhone 5S"
        
    case "iPhone7,1":
        return "iPhone 6 Plus"
        
    case "iPhone7,2":
        return "iPhone 6"
        
    case "iPhone8,1":
        return "iPhone 6s"
        
    case "iPhone8,2":
        return "iPhone 6s Plus"
        
    case "iPhone8,4":
        return "iPhone SE"
        
    case "iPhone9,1", "iPhone9,3":
        return "iPhone 7"
        
    case "iPhone9,2", "iPhone9,4":
        return "iPhone 7 Plus"
        
    case "iPhone10,1", "iPhone10,4":
        return "iPhone 8"
        
    case "iPhone10,2", "iPhone10,5":
        return "iPhone 8 Plus"
        
    case "iPhone10,3", "iPhone10,6":
        return "iPhone X"
        
    case "iPhone11,8":
        return "iPhone XR"
        
    case "iPhone11,2":
        return "iPhone XS"
        
    case "iPhone11,6", "iPhone11,4":
        return "iPhone XS Max"
        
    // iPod Touch
    case "iPod1,1":
        return "iPod Touch"
        
    case "iPod2,1":
        return "iPod Touch 2"
        
    case "iPod3,1":
        return "iPod Touch 3"
        
    case "iPod4,1":
        return "iPod Touch 4"
        
    case "iPod5,1":
        return "iPod Touch 5"
        
    // iPad
    case "iPad1,1":
        return "iPad"
        
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
        return "iPad 2"
        
    case "iPad2,5", "iPad2,6", "iPad2,7":
        return "iPad Mini 1"
        
    case "iPad3,1", "iPad3,2", "iPad3,3":
        return "iPad 3"
        
    case "iPad3,4", "iPad3,5", "iPad3,6":
        return "iPad 4"
        
    case "iPad4,1", "iPad4,2", "iPad4,3":
        return "iPad air"
        
    case "iPad4,4", "iPad4,5", "iPad4,6":
        return "iPad mini 2"
        
    case "iPad4,7", "iPad4,8", "iPad4,9":
        return "iPad mini 3"
        
    case "iPad5,1", "iPad5,2":
        return "iPad mini 4"
        
    case "iPad5,3", "iPad5,4":
        return "iPad air 2"
        
    case "iPad6,7", "iPad6,8":
        return "iPad Pro 12.9-inch"
        
    case "iPad6,3", "iPad6,4":
        return "iPad Pro iPad 9.7-inch"
        
    case "iPad6,10", "iPad6,11":
        return "iPad 5"
        
    case "iPad7,1", "iPad7,2":
        return "iPad Pro 12.9-inch(2nd)"
        
    case "iPad7,3", "iPad7,4":
        return "iPad Pro 10.5-inch"
        
    case "iPad7,5", "iPad7,6":
        return "iPad(6th)"
        
    case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":
        return "iPad Pro 11-inch"
        
    case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":
        return "iPad Pro 12.9-inch(3rd)"
        
    // 模拟器
    case "x86_64", "iPhone Simulator":
        return "iPhone Simulator"
        
    default:
        return identifier
    }
}
