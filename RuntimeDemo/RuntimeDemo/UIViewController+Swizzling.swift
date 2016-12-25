//
//  UIViewController+Swizzling.swift
//  RuntimeDemo
//
//  Created by liyy on 2016/12/25.
//  Copyright © 2016年 liyy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    open override static func initialize() {
        // 确保不是子类
        if self !== UIViewController.self {
            return
        }
        
        let originalSelector = #selector(UIViewController.viewWillAppear(_:))
        let swizzledSelector = Selector(("newViewWillAppear:"))
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
    
    // MARK: - Method Swizzling
    
    func newViewWillAppear(animated: Bool) {
        self.newViewWillAppear(animated: animated)
        
        if let name = self.descriptiveName {
            print("viewWillAppear: \(name)")
        } else {
            print("viewWillAppear: \(self)")
        }
    }
    
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    
    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
