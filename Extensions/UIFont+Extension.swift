//
//  UIFont+Extension.swift
//  UME
//
//  Created by zlm on 16/7/22.
//  Copyright © 2016年 yealink. All rights reserved.
// 该类不提供对外使用

import UIKit
extension UIFont {

    /// 默认字体 整体调整过大小
    open class func fontWithHelvetica(_ fontSize: CGFloat, _ isAutoSize: Bool? = false) -> UIFont {
        var autoSize = fontSize
        if kScreenWidth == 320 {
            //小屏幕

        } else {
            autoSize = fontSize + 2
        }
        
        if let font = UIFont(name: MMkFontTextDefault, size: autoSize) {
            return font
        }
        
        return UIFont.systemFont(ofSize: autoSize)
    }

    ///
    open class func fontWithHelveticaBold(_ fontSize: CGFloat, _ isAutoSize: Bool? = false) -> UIFont {
        var autoSize = fontSize
        if kScreenWidth == 320 {
            //小屏幕

        } else {
            autoSize = fontSize + 2
        }
        
        if let font = UIFont(name: MMkFontTextDefaultBold, size: autoSize) {
            return font
        }
        
        return UIFont.boldSystemFont(ofSize: autoSize)
    }

    ///
    open class func fontWithHelveticaLight(_ fontSize: CGFloat, _ isAutoSize: Bool? = false) -> UIFont {
        var autoSize = fontSize
        if kScreenWidth == 320 {
            //小屏幕

        } else {
            autoSize = fontSize + 2
        }
        
        if let font = UIFont(name: MMkFontTextDefaultLight, size: autoSize) {
            return font
        }
        
        return UIFont.systemFont(ofSize: autoSize)
    }
}

