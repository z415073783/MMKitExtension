//
//  UIColor+MMColor.swift
//  UME
//
//  Created by zlm on 16/7/18.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit
public extension UIColor {

    convenience init(MMRed: CGFloat, MMGreen: CGFloat, MMBlue: CGFloat, MMAlpha: CGFloat) {
        self.init(red: MMRed/255.0, green: MMGreen/255.0, blue: MMBlue/255.0, alpha: MMAlpha)
    }

    class func colorWithHex(hexColor: String, alpha: Float) -> UIColor {
        var hex = hexColor
        if hex.hasPrefix("#") {
            hex = hex.filter {$0 != "#"}
        }
        if let hexVal = Int(hex, radix: 16) {
            return UIColor._colorWithHex(hexColor: hexVal, alpha: CGFloat(alpha))
        }
        else {
            return UIColor.clear
        }
    }

    class func _colorWithHex(hexColor: CLong, alpha: CGFloat) -> UIColor {
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
        let blue = ((CGFloat)((hexColor & 0xFF))/255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
typealias __NewColor = UIColor
public extension __NewColor {
    /// 主色调
    static let mainColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#1786d4", alpha: 1)
    }()
    
    /// 常用色
    static let blackColor: UIColor = {
        return UIColor(red: 58.0/255.0, green: 58.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    }()
    /// 灰色
    static let grayColor: UIColor = {
        return UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    }()
    /// 白色 高亮
    static let whiteHeightLightColor: UIColor = {
        return UIColor(MMRed: 232, MMGreen: 232, MMBlue: 232, MMAlpha: 1)
    }()
    
    
    // MARK: 文字
    /// 黑色文字
    static let textBlackColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#333333", alpha: 1)
    }()
    /// 浅灰色文字
    static let textLightGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#cccccc", alpha: 1)
    }()
    /// 中灰色文字
    static let textMediumGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#b3b3b3", alpha: 1)
    }()
    /// 灰色文字
    static let textGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#999999", alpha: 1)
    }()
    /// 提示文字颜色 最浅颜色
    static let textHintColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#bbbbbb", alpha: 1)
    }()
    /// 绿色文字
    static let textGreenColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#08afa5", alpha: 1)
    }()
    /// 蓝色文字
    static let textBlueColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#1786d4", alpha: 1)
    }()
    /// 红色文字
    static let textRedColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#fd3939", alpha: 1)
    }()
    /// 金黄色文字
    static let textGoldenYellowColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#f7ba2a", alpha: 1)
    }()
    /// 重要文字提醒
    static let textImportant: UIColor = {
        return UIColor.colorWithHex(hexColor: "#333333", alpha: 1)
    }()
    
    
    // MARK: 线条颜色
    /// 线条 深灰
    static let lineDarkGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#b2b2b2", alpha: 1)
    }()
    /// 线条 中灰
    static let lineMediumGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#d8d8d8", alpha: 1)
    }()
    /// 线条 浅灰
    static let lineLightGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#e8e8e8", alpha: 1)
    }()
    /// 黑色 透明度0.1
    static let lineBlackAlphaColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#000000", alpha: 0.1)
    }()
    
    // MARK: 背景色
    /// 最浅颜色背景
    static let backgackgroundTintColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#f5f7fa", alpha: 1)
    }()
    /// 亮灰色背景
    static let backgroundLightGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#f0f2f5", alpha: 1)
    }()
    /// 灰色背景
    static let backgroundGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#f4f5f6", alpha: 1)
    }()
    
    // MARK: 按钮
    /// 按钮主色调 normal
    static let buttonColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#2ca7e5", alpha: 1)
    }()
    /// 按钮主色调 highLight
    static let buttonHighLightColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#2793c9", alpha: 1)
    }()
    /// 红色按钮 normal
    static let buttonRedColorYL: UIColor = {
        return UIColor.colorWithHex(hexColor: "#ef3939", alpha: 1)
    }()
    /// 红色按钮 highLight
    static let buttonRedHighLightColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#ef3939", alpha: 1)
    }()
    /// 蓝色按钮 normal
    static let buttonBlueColor: UIColor = {
        return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }()
    /// 灰色按钮 normal
    static let buttonGrayColor: UIColor = {
        return UIColor.colorWithHex(hexColor: "#8e8e8e", alpha: 1)
    }()
    
}
