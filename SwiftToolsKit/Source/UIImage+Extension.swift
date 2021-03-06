//
//  UIImage+Extension.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

extension UIImage: STKNamespaceWrappable { }

extension STKTypeWrapperProtocol where STKWrappedType: UIImage {
    
    /// 根据颜色创建图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - rect: 范围
    /// - Returns: 创建的图片
    public static func createImage(with color: UIColor, _ rect: CGRect? = nil) -> UIImage? {
        let newRect = (rect == nil) ? CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0) : rect!
        UIGraphicsBeginImageContext(newRect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(newRect)
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
    
    
    // MARK: - 由图片裁剪出另一张图片
    /// 由图片裁剪出另一张图片
    ///
    /// - Parameters:
    ///   - aImage: 原始图片
    ///   - cutRect: 裁剪范围
    /// - Returns: 裁剪所得的图片
    public static func cutImage(from aImage: UIImage, cutRect: CGRect) -> UIImage? {
        guard let cgImage = aImage.cgImage?.cropping(to: cutRect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
