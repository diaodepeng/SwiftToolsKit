//
//  UILabel+Extension.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    // MARK: - 快速创建Label
    /// 快速创建Label
    ///
    /// - Parameters:
    ///   - textColor: 文本颜色
    ///   - font: 文本设置
    ///   - text: 文本
    public convenience init(text: String? = nil, textColor: UIColor, font: UIFont) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
    }
    
}

extension TypeWrapperProtocol where WrappedType: UILabel {
    
    // MARK: - 测算Label显示文字所需高度
    /// 测算Label显示文字所需高度
    ///
    /// - Parameters:
    ///   - width: 给定宽度
    ///   - font: 字号
    ///   - lineSpacing: 行间距
    ///   - text: 文字
    /// - Returns: 高度
    public func getSpaceLabelHeight(byWith width: CGFloat, font: UIFont, lineSpacing: CGFloat, text: String) -> CGFloat{
        
        //设置label行距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        wrappedValue.attributedText = attributedString
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, (text.count)))
        
        //计算label字符串的高度
        let rect: CGRect = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                             options: .usesLineFragmentOrigin,
                                             attributes: [.font: font,
                                                          .paragraphStyle: paragraphStyle],
                                             context: nil)
        
        return rect.size.height
    }
}
