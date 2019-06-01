//
//  UIView+ViewController.swift
//  MMBaseFramework
//
//  Created by soft7 on 2018/5/10.
//  Copyright © 2018年 Yealink. All rights reserved.
//

import Foundation

extension UIView {
    
    public func MM_viewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
}
