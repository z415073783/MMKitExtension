//
//  MMButton.swift
//  Odin-UC
//
//  Created by zlm on 2016/12/8.
//  Copyright © 2016年 yealing. All rights reserved.
//

import UIKit

open class MMButton: UIButton {

    // MARK: - 👉 init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        buttonDidInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buttonDidInit()
    }
    
    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    open func buttonDidInit() {
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
    }
    
    private var _touchUpInsideCallback:((_ info:MMButton?) -> Void)?
    public func setTouchUpInsideCallBack(block: @escaping (_ info:MMButton?) -> Void) {
        _touchUpInsideCallback = block
        addTarget(self, action: #selector(selfDidTap(_:)), for: .touchUpInside)
    }
    private var _touchLongPressCallback:MMCallBlockFunc?
    public func setTouchLongPressCallBack(block: @escaping MMCallBlockFunc) {
        _touchLongPressCallback = block
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longTouchInside(sender:))))
    }
    /// 设置背景色
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - state: 需要设置的状态
//    open func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
//        setBackgroundImage(UIImage.imageWithColor(color: color), for: state)
//    }

    @objc open func selfDidTap(_ sender: Any) {
         MMLOG.controlInfo("Button call block:\(self.description)")
        _touchUpInsideCallback?(self)
    }
    @objc open func longTouchInside(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            _touchLongPressCallback?(sender)
        }
    }

}
