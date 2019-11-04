//
//  String+Encryption.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
//import CommonCrypto

//extension TypeWrapperProtocol where WrappedType == String {
//
//    // MARK: - AES加解密
//
//    /// AES加密 128/192/256
//    ///
//    /// - Parameters:
//    ///   - plainText: 明文
//    ///   - key: 密钥
//    /// - Returns: 加密后的二进制数据
//    public static func AES128Encrypt(plainText: String, key: String, iv: String) -> Data? {
//        guard let data = plainText.data(using: .utf8) else { return nil }
//        return self.AESOperation(type: .AES128Type, operation: CCOperation(kCCEncrypt), data: data, key: key, iv: iv)
//    }
//
//    public static func AES192Encrypt(plainText: String, key: String, iv: String) -> Data? {
//        guard let data = plainText.data(using: .utf8) else { return nil }
//        return self.AESOperation(type: .AES192Type, operation: CCOperation(kCCEncrypt), data: data, key: key, iv: iv)
//    }
//
//    public static func AES256Encrypt(plainText: String, key: String, iv: String) -> Data? {
//        guard let data = plainText.data(using: .utf8) else { return nil }
//        return self.AESOperation(type: .AES256Type, operation: CCOperation(kCCEncrypt), data: data, key: key, iv: iv)
//    }
//
//
//    /// AES解密 128/192/256
//    ///
//    /// - Parameters:
//    ///   - cipherData: 密文 二进制数据
//    ///   - key: 密钥
//    /// - Returns: 解密后的二进制数据
//    public static func AES128Decrypt(cipherData: Data, key: String, iv: String) -> Data? {
//        return self.AESOperation(type: .AES128Type, operation: CCOperation(kCCDecrypt), data: cipherData, key: key, iv: iv)
//    }
//
//    public static func AES192Decrypt(cipherData: Data, key: String, iv: String) -> Data? {
//        return self.AESOperation(type: .AES192Type, operation: CCOperation(kCCDecrypt), data: cipherData, key: key, iv: iv)
//    }
//
//    public static func AES256Decrypt(cipherData: Data, key: String, iv: String) -> Data? {
//        return self.AESOperation(type: .AES256Type, operation: CCOperation(kCCDecrypt), data: cipherData, key: key, iv: iv)
//    }
//
//
//    /// AES
//    ///
//    /// - Parameters:
//    ///   - type: 密钥长度
//    ///   - operation: 操作 加密or解密
//    ///   - data: 要操作的数据
//    ///   - key: 密钥
//    /// - Returns: 操作后的数据
//    static private func AESOperation(type: AESKeySizeType,
//                                     operation: CCOperation,
//                                     data: Data,
//                                     key: String,
//                                     iv: String) -> Data? {
//
//        let data = NSData(data: data)
//        let dataLength = data.length
//        let dataBytes = data.bytes
//
//        let places = type.rawValue - key.count
//        let wholeKey = key + String(repeating: "\0", count: places < 0 ? 0 : places)
//        let keyBytes = (wholeKey.data(using: .utf8)! as NSData).bytes
//        let keyLength = type.rawValue
//
//        let bufferSize: size_t = dataLength + kCCBlockSizeAES128
//        let buffer: UnsafeMutableRawPointer? = malloc(bufferSize)
//
//        var numBytes: size_t = 0
//        let cryptStatus: CCCryptorStatus = CCCrypt(CCOperation(operation), CCAlgorithm(kCCAlgorithmAES128),
//                                                   CCOptions(kCCOptionPKCS7Padding),
//                                                   keyBytes, keyLength,
//                                                   iv,
//                                                   dataBytes, dataLength,
//                                                   buffer, bufferSize,
//                                                   &numBytes)
//
//        if Int(cryptStatus) == kCCSuccess {
//            let data = Data(bytes: buffer!, count: numBytes)
//            free(buffer)
//            return data
//        }
//        free(buffer)
//
//        return nil
//    }
//
//
//    // MARK: - DES加解密
//
//    /// DES加密
//    ///
//    /// - Parameters:
//    ///   - plainText: 明文
//    ///   - key: 密钥
//    /// - Returns: 加密完成后的二进制数据
//    public static func DESEncrypt(plainText: String, key: String, iv: String) -> Data? {
//        guard let data = plainText.data(using: .utf8) else { return nil }
//        return self.DESOperation(operation: CCOperation(kCCEncrypt), data: data, key: key, iv: iv)
//    }
//
//
//    /// DES解密
//    ///
//    /// - Parameters:
//    ///   - cipherData: 二进制密文
//    ///   - key: 密钥
//    /// - Returns: 解密完成后的二进制数据
//    public static func DESDecrypt(cipherData: Data, key: String, iv: String) -> Data? {
//        return self.DESOperation(operation: CCOperation(kCCDecrypt), data: cipherData, key: key, iv: iv)
//    }
//
//
//    /// DES
//    ///
//    /// - Parameters:
//    ///   - operation: 操作 (加密or解密)
//    ///   - data: 进行操作的数据
//    ///   - key: 密钥
//    /// - Returns: 经过操作的数据
//    static private func DESOperation(operation: CCOperation,
//                                     data: Data,
//                                     key: String,
//                                     iv: String) -> Data? {
//
//        let data = NSData.init(data: data)
//        let dataLength = data.length
//        let dataBytes = data.bytes
//
//        let bufferSize: size_t = dataLength + kCCBlockSizeDES
//        let buffer: UnsafeMutableRawPointer? = malloc(bufferSize)
//
//        let keyBytes = (key.data(using: .utf8)! as NSData).bytes
//
//        var numBytes: size_t = 0
//        let cryptStatus: CCCryptorStatus = CCCrypt(CCOperation(operation), CCAlgorithm(kCCAlgorithmDES),
//                                                   CCOptions(kCCOptionPKCS7Padding),
//                                                   keyBytes, kCCKeySizeDES,
//                                                   iv,
//                                                   dataBytes, dataLength,
//                                                   buffer, bufferSize,
//                                                   &numBytes)
//
//        if Int(cryptStatus) == kCCSuccess {
//            let data = Data.init(bytes: buffer!, count: numBytes)
//            free(buffer)
//            return data
//        }
//
//        free(buffer)
//
//        return nil
//    }
//
//
//    // MARK: - MD5编码
//
//    /// MD5编码
//    ///
//    /// - Parameter str: 要进行MD5编码的字符串
//    /// - Returns: 进行MD5编码后的字符串
//    public static func MD5String(str: String) -> String{
//        let cStr = str.cString(using: .utf8);
//        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
//
//        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
//
//        var md5String = String()
//        for i in 0 ..< 16{
//            md5String += String(format: "%02x", buffer[i])
//        }
//        free(buffer)
//
//        return md5String
//    }
//
//    // MARK: - MD2编码
//
//    /// MD2编码
//    ///
//    /// - Parameter str: 要进行MD2编码的字符串
//    /// - Returns: 进行MD2编码后的字符串
//    public static func MD2String(str: String) -> String{
//        let cStr = str.cString(using: .utf8);
//        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
//
//        CC_MD2(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
//
//        var md2String = String()
//        for i in 0 ..< 16{
//            md2String += String(format: "%02x", buffer[i])
//        }
//        free(buffer)
//
//        return md2String
//    }
//
//
//    // MARK: - Base64编解码
//
//    /// 对字符串进行base64编码
//    ///
//    /// - Parameter text: 要编码的字符串
//    /// - Returns: 编码后的字符串
//    public static func base64EncodedString(fromString text: String?) -> String? {
//        guard let text = text, !text.isEmpty else { return nil }
//        return String.stk.base64EncodedData(fromData: text.data(using: .utf8)!)
//    }
//
//
//    /// 对base64字符串进行解码
//    ///
//    /// - Parameter text: 要解码的base64字符串
//    /// - Returns: 解码后的字符串
//    public static func base64DecodedString(fromString text: String?) -> Data? {
//        guard let text = text, !text.isEmpty else { return nil }
//        return String.stk.base64DecodedData(fromData: text.data(using: .utf8)!)
//    }
//
//
//    /// 对数据进行base64编码
//    ///
//    /// - Parameter data: 要编码的数据
//    /// - Returns: 编码后的数据
//    public static func base64EncodedData(fromData data: Data?) -> String? {
//        guard let data = data else { return nil }
//        let base64Data = data.base64EncodedData(options: .lineLength64Characters)
//        return String.init(data: base64Data, encoding: .ascii)
//    }
//
//
//    /// 对base64数据进行解码
//    ///
//    /// - Parameter data: 要解码的base64数据
//    /// - Returns: 解码后的数据
//    public static func base64DecodedData(fromData data: Data?) -> Data? {
//        guard let data = data else { return nil }
//        return Data(base64Encoded: data, options: .ignoreUnknownCharacters)
//    }
//
//}
