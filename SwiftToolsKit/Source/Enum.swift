//
//  Enum.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation

// 日期格式枚举
public enum DateFormatType: String {
    case normal             = "yyyy-MM-dd HH:mm:ss"
    case yyMdHm             = "yy-MM-dd HH:mm"
    case yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case yMd                = "yyyy-MM-dd"
    case MdHms              = "MM-dd HH:mm:ss"
    case MdHm               = "MM-dd HH:mm"
    case Hms                = "HH:mm:ss"
    case Hm                 = "HH:mm"
    case Md                 = "MM-dd"
    case yyMd               = "yy-MM-dd"
    case YYMMdd             = "yyyyMMdd"
    case yyyyMdHms          = "yyyyMMddHHmmss"
    case yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case yMdWithSlash       = "yyyy/MM/dd"
    case yM                 = "yyyy-MM"
    case yMdChangeSeparator = "yyyy.MM.dd"
}

// AES 加密类型
public enum AESKeySizeType: Int {
    case AES128Type = 16
    case AES192Type = 24
    case AES256Type = 32
}
