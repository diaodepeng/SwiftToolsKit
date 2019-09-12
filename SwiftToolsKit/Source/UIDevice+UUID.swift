//
//  String+UUID.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//
//  结合Keychain存储与获取设备UUID
//

import UIKit
import Security

extension UIDevice: NamespaceWrappable { }
extension TypeWrapperProtocol where WrappedType: UIDevice {
    
    /// 获取设备UUID(同组设备唯一)
    ///
    /// - Returns: UUID字符串
    public static func getUUIDString() -> String {
        
        // 查询是否存在已存储的UUID
        
        var searchResult: AnyObject?
        let searchStatus = SecItemCopyMatching(keychainSearchAttributes as CFDictionary, &searchResult)
        
        if searchStatus == noErr {
            if let data = searchResult as? Data, let uuidString = String(data: data, encoding: .utf8) {
                return uuidString
            } else {
                return ""
            }
        }
        
        // 获取UUID并储存
        
        guard let tmpUUID = UIDevice.current.identifierForVendor?.uuidString else { return "" }
        
        let uuidString = tmpUUID.replacingOccurrences(of: "-", with: "")
        var attributes = keychainBaseAttributes
        
        guard let uuidData = uuidString.data(using: .utf8) else { return "" }
        
        attributes[kSecValueData as String] = uuidData
        let status = SecItemAdd(attributes as CFDictionary, nil)
        
        if status == errSecSuccess {
            return uuidString
        } else if status == errSecDuplicateItem, self.update(valueData: uuidData) == true {
            return uuidString
        } else {
            return ""
        }
        
    }
    
    // MARK: - Private method
    
    /// 更新存储信息
    ///
    /// - Parameter valueData: 新的存储值
    /// - Returns: 更新成功标志
    private static func update(valueData: Data) -> Bool {
        let updateDictionary = [kSecValueData as String : valueData]
        let status = SecItemUpdate(keychainBaseAttributes as CFDictionary, updateDictionary as CFDictionary)
        return status == errSecSuccess
    }
    
    /// Keychain字典搜索配置
    private static var keychainSearchAttributes: [String: Any] {
        get {
            
            return [
                kSecMatchLimit as String : kSecMatchLimitOne,
                kSecReturnData as String : kCFBooleanTrue!,
                kSecClass as String : kSecClassGenericPassword,
                kSecAttrService as String : "com.SwiftyTools",
                kSecAttrAccount as String : "com.SwiftyTools",
                kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlock
            ]
            
        }
    }
    
    /// Keychain字典基础配置
    private static var keychainBaseAttributes: [String: Any] {
        get {
            
            return [
                kSecClass as String : kSecClassGenericPassword,
                kSecAttrService as String : "com.SwiftyTools",
                kSecAttrAccount as String : "com.SwiftyTools",
                kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlock
            ]
            
        }
    }
}
