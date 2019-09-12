//
//  RoundedCornersImageView.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import UIKit

public class RoundedCornersImageView: UIImageView {
    
    private var imageContext = 0
    
    private struct sharedInstance {
        static var dellocShared : NSObject?
        static var layoutShared : NSObject?
    }
    
    // MARK: - Property
    private struct propertyKey {
        static var hadAddObserverKey : Void?
        static var isRoundingKey : Void?
        static var borderColorKey : Void?
        static var borderWidthKey : Void?
        static var roundingCornersKey : Void?
        static var radiusKey : Void?
        static var processedImageKey : Void?
    }
    
    private var radius: CGFloat?
    private var roundingCorners: UIRectCorner?
    private var borderWidth : CGFloat?
    private var borderColor : UIColor?
    private var hadAddObserver : Bool?
    private var isRounding : Bool?
    
    // MARK: - Initial
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if hadAddObserver == true {
            self.removeObserver(self, forKeyPath: "image", context: &imageContext)
        }
    }
    
    // MARK: - Public Methods
    
    /// 初始化设置圆角半径, 需要设置圆角的角
    ///
    /// - Parameters:
    ///   - cornerRadius: 半径
    ///   - rectCornerType: 需要设置圆角的角
    public convenience init(CornerRadiusAdvance cornerRadius: CGFloat, CornerType rectCornerType: UIRectCorner) {
        self.init(frame: CGRect.zero)
        self.cornerRadiusAdvance(cornerRadius: cornerRadius, rectcornerType: rectCornerType)
    }
    
    /// 设置边框大小, 颜色bv
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - color: 颜色
    public func attachBorder(width: CGFloat, color: UIColor) {
        borderColor = color
        borderWidth = width
    }
    
    /// 给图片设置圆角半径, 需要设置圆角的角
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - rectcornerType: 需要设置圆角的角
    public func cornerRadiusAdvance(cornerRadius: CGFloat, rectcornerType: UIRectCorner) {
        
        radius = cornerRadius
        roundingCorners = rectcornerType
        isRounding = false
        
        if hadAddObserver != true {
            self.addObserver(self, forKeyPath: "image", options: .new, context: &imageContext)
            hadAddObserver = true
        }
        
        //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
        self.layoutIfNeeded()
    }
    
    /// 调用此方法默认绘制圆形, 无边框
    public func cornerRadiusRoundingRect() {
        isRounding = true
        if hadAddObserver == nil {
            self.addObserver(self, forKeyPath: "image", options: .new, context: &imageContext)
            self.hadAddObserver = true
        }
        
        //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
        self.layoutIfNeeded()
    }
    
    // MARK: - Override
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if image != nil {
            if isRounding == true {
                cornerRadius(image!, radius: frame.width / 2, rectCornerType: .allCorners)
                
            } else if radius != 0 && self.image != nil && (self.roundingCorners == .topRight
                || self.roundingCorners == .topLeft
                || self.roundingCorners == .bottomRight
                || self.roundingCorners == .bottomLeft
                || self.roundingCorners == .allCorners) {
                cornerRadius(image!, radius: radius!, rectCornerType: roundingCorners!)
            }
        }
    }
    
    // MARK: - Kernel
    
    private func cornerRadius(_ image: UIImage, radius: CGFloat, rectCornerType: UIRectCorner, backgroundColor: UIColor? = nil) {
        let size : CGSize = self.bounds.size
        let scale = UIScreen.main.scale
        let cornerRadii = CGSize(width: radius, height: radius)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let currentContext = UIGraphicsGetCurrentContext()
        if currentContext == nil {
            return
        }
        
        let cornerPath: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCornerType, cornerRadii: cornerRadii)
        
        if backgroundColor != nil {
            let backgroundRect = UIBezierPath(rect: self.bounds)
            backgroundColor?.setFill()
            backgroundRect.fill()
        }
        
        cornerPath.addClip()
        
        self.layer.render(in: currentContext!)
        self.drawBorder(path: cornerPath)
        
        let processedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        if processedImage != nil {
            objc_setAssociatedObject(processedImage!, &propertyKey.processedImageKey, 1, objc_AssociationPolicy(rawValue: 1)!)
        }
        self.image = processedImage
    }
    
    // MARK: - Private method
    
    private func drawBorder(path: UIBezierPath) {
        if borderWidth != 0 && borderColor != nil {
            path.lineWidth = 2 * borderWidth!
            borderColor?.setStroke()
            path.stroke()
        }
    }
    
    private func validateFrame() {
        if self.frame.size.width == 0 {
            if image != nil {
                if isRounding == true {
                    cornerRadius(image!, radius: frame.width / 2, rectCornerType: .allCorners)
                    
                } else if radius != 0 && self.image != nil && (self.roundingCorners == .topRight
                    || self.roundingCorners == .topLeft
                    || self.roundingCorners == .bottomRight
                    || self.roundingCorners == .bottomLeft
                    || self.roundingCorners == .allCorners) {
                    cornerRadius(image!, radius: radius!, rectCornerType: roundingCorners!)
                }
            }
        }
    }
    
    // MARK: - KVO for .image
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            
            let index = change?.index(forKey: .newKey)
            let newImage : AnyObject = change![index!].value as AnyObject
            
            if newImage.isMember(of: NSNull.self) {
                return
            } else if objc_getAssociatedObject(newImage, &propertyKey.processedImageKey) != nil {
                return
            }
            self.validateFrame()
            
            if self.isRounding == true {
                cornerRadius(image!, radius: frame.width / 2, rectCornerType: .allCorners)
                
            } else if radius != 0
                && self.image != nil
                && (self.roundingCorners == .topRight
                    || self.roundingCorners == .topLeft
                    || self.roundingCorners == .bottomRight
                    || self.roundingCorners == .bottomLeft
                    || self.roundingCorners == .allCorners) {
                cornerRadius(newImage as! UIImage, radius: radius!, rectCornerType: roundingCorners!)
            }
        }
    }
}
