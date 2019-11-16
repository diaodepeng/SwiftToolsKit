//
//  UIButton+Extension.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

extension STKTypeWrapperProtocol where STKWrappedType: UIButton {
    
    // MARK: - 文字图片置换方法 (左 title 右 image)
    /// 文字图片置换方法 (左 title 右 image) 在每次设置 title 和 image 之后调用
    public func leftTitleAndRightImageFits() {
        let imageWidth = stkWrappedValue.imageView?.width
        let labelWidth = stkWrappedValue.titleLabel?.width
        
        if let imageWidth = imageWidth, let labelWidth = labelWidth {
            stkWrappedValue.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth, bottom: 0, right: -labelWidth)
            stkWrappedValue.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
        }
    }
    
    // MARK: - 文字图片置换方法 (上 image 下 title)
    /// 文字图片置换方法 (上 image 下 title) 在每次设置 title 和 image 之后调用
    public func topImageAndBottomTitleFits() {
        self.topImageAndBottomTitleFitsWith(space: 6.0)
    }
    
    /// 文字图片置换方法 (上 image 下 title) 在每次设置 title 和 image 之后调用
    ///
    /// - Parameter space: title 与 image 之间的距离
    public func topImageAndBottomTitleFitsWith(space: CGFloat) {
        let imageSize = stkWrappedValue.imageView?.frame.size
        let titleSize = stkWrappedValue.titleLabel?.frame.size
        
        if let imageSize = imageSize, let titleSize = titleSize {
            let totalHeight = (imageSize.height + titleSize.height + space)
            
            stkWrappedValue.titleEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height), left: -imageSize.width, bottom: 0, right: 0)
            stkWrappedValue.imageEdgeInsets = UIEdgeInsets(top: titleSize.height, left: titleSize.width, bottom: 0, right: 0)
        }
    }
}
