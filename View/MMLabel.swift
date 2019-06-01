//
//  MMLabel.swift
//  Odin-YMS
//
//  Created by zlm on 2017/4/24.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import UIKit

open class MMLabel: UILabel {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        labelDidInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        labelDidInit()
    }
    
    open func labelDidInit() {
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
        font = UIFont.fontWithHelvetica(14)
        textColor = UIColor.black
    }
    
    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }
}
