//
//  UIView+Extension.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation
import UIKit

extension UIView: NamespaceWrappable { }

public extension UIView {
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat? {
        get {
            return self.frame.size.width
        }
        
        set {
            self.frame.size.width = newValue!
        }
    }
    
    var height: CGFloat? {
        get {
            return self.frame.size.height
        }
        
        set {
            self.frame.size.height = newValue!
        }
    }
    
    var centerX: CGFloat? {
        get {
            return self.center.x
        }
        
        set {
            self.center = CGPoint(x: newValue!, y: self.center.y)
        }
    }
    
    var centerY: CGFloat? {
        get {
            return self.center.y
        }
        
        set {
            self.center = CGPoint(x: self.center.x, y: newValue!)
        }
    }
    
    
    // MARK: - 获取当前View的控制器对象
    /// 获取当前View的控制器对象
    ///
    /// - Returns: 控制器对象
    func currentViewController() -> UIViewController? {
        var next = self.next
        repeat{
            if next is UIViewController {
                return next as? UIViewController
            }
            next = next?.next
        } while next != nil
        
        return nil
    }
    
    // MARK: - 查找当前view.subViews中符合空间名的控件
    ///  查找当前view.subViews中符合空间名的控件
    ///
    /// - Parameter className: 控件名
    /// - Returns: 该控件
    func subView(of className: String) -> UIView? {
        for subView: UIView in self.subviews {
            if NSStringFromClass(type(of: subView)) == className {
                return subView
            }
            
            let resultFound = subView.subView(of: className)
            if resultFound != nil {
                return resultFound
            }
        }
        return nil
    }
}
