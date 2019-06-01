//
//  UIButton+Extension.swift
//  UME
//
//  Created by zlm on 16/8/9.
//  Copyright © 2016年 yealink. All rights reserved.
//

import Foundation
public extension UIButton {
    /**
     通过手势点击(规避navigationbar上的按钮响应延迟问题)
     
     - parameter target: target
     - parameter action: action
     */
    func MMaddtarget(_ target: AnyObject?, action: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }

    /// 设置背景色
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - state: 需要设置的状态
    open func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage.imageWithColor(color: color), for: state)
    }

}
