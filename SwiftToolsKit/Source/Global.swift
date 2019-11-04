//
//  Global.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

/// 获取当前 APP 的 Version 版本号
///
/// - Returns: APP 的 Version 版本号
public func APP_VERSION() -> String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

/// 获取当前 APP 的 Build 版本号
///
/// - Returns: APP 的 Build 版本号
public func APP_BUILD() -> String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}

/// 获取 iOS 系统版本
///
/// - Returns: 系统版本
public func SYSTEM_VERSION() -> String {
    return UIDevice.current.systemName + UIDevice.current.systemVersion
}

/// 验证手机号是否合法
///
/// - Parameter number: 手机号
/// - Returns: 验证结果
public func checkIsPhoneNumber(_ number: String) -> Bool {
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
    
    let a = #"^((13[0-9])"#
    let b = #"|(14[5,7,9])"#
    let c = #"|(15([0-3]|[5-9]))"#
    let d = #"|(166)"#
    let e = #"|(17[0-3]|[5-8])"#
    let f = #"|(18[0-9])"#
    let g = #"|(19[8|9]))"#
    let h = #"\d{8}$"#
    
    let pattern = [a, b, c, d, e, f, g, h].joined()
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@", pattern)
    return regextestmobile.evaluate(with: number) == true
}
