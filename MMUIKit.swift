//
//  MMUIKit.swift
//  MMUIKit
//
//  Created by yealink-dev on 2018/7/6.
//

import Foundation
import UIKit

//@_exported import MMFoundation
@_exported import SnapKit

public typealias MMLOG = MMLogger


/** 屏幕宽度  */
public var kScreenWidth: Float {
    get {
        return Float(UIScreen.main.bounds.size.width)
    }
}

/** 屏幕高度  */
public var kScreenHight: Float {
    get {
        return Float(UIScreen.main.bounds.size.height)
    }
}

public var kRootViewController: UIViewController? {
    let vc = UIApplication.shared.delegate?.window??.rootViewController
    return vc
}
