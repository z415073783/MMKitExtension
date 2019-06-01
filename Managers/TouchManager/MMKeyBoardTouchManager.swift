//
//  MMKeyBoardTouchManager.swift
//  UME
//
//  Created by zlm on 16/8/17.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

public class MMKeyBoardTouchManager: UIView {
    public static let getInstance: MMKeyBoardTouchManager = MMKeyBoardTouchManager()
    var keyboardState: Bool = false  //是否已打开键盘
    
    private var listenQueue: Dictionary<String, ViewHolder> = [:]
    
    class ViewHolder: NSObject {
        weak var owner: UIView?
        
        init(_ view: UIView?) {
            self.owner = view
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            if let holder = object as? ViewHolder {
                return owner == holder.owner
            }
            
            if let view = object as? UIView {
                return owner == view
            }
            
            return false
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardDidHideNotification, object: nil)

    }
    @objc func keyboardShow() {
        keyboardState = true
    }
    @objc func keyboardHide() {
        keyboardState = false
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView() {
        removeFromSuperview()
        
        if let window = kAppWindow {
            window.addSubview(self)
            
            self.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }
        }
    }

    var _times: TimeInterval = 0

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let event = event else { return nil }
//        MMLOG.debug("point = \(point), event = \(event)")
        if _times != event.timestamp {
            _times = event.timestamp
            return nil  //穿透  第一次进入不处理事件
        }
        
        if let vc = kRootViewController as? UINavigationController {
            let navigationBarpoint = vc.navigationBar.convert(point, from: self)
            let isInside = vc.navigationBar.isInside(point: navigationBarpoint)
            if isInside {
                return nil
            }
        }
        else {
            return nil
        }
        
        //遍历已注册的view,如果在指定视图内则直接返回,不关闭键盘
        for (key, value) in listenQueue {
//            MMLOG.debug("\(key)")
            let view: UIView? = value.owner
            
            if view == nil {
                MMKeyBoardTouchManager.getInstance.listenQueue[key] = nil
            }
            
            //如果view正在显示
            if let v = view, v.window != nil, v.isHidden == false {
                let localPoint = v.convert(point, from: self)
                let isOk = v.isInside(point: localPoint)
                if isOk == true {
                    return nil
                }
            }
        }

        if keyboardState == true {
            kAppWindow?.endEditing(true)//隐藏键盘
            return nil  //穿透or不穿透
        }
        return nil  //穿透
    }

// MARK: 对外接口
    public class func addView(view: UIView) {
        let holder = ViewHolder(view)
        MMKeyBoardTouchManager.getInstance.listenQueue[view.MMgetAddressIdentifity()] = holder
    }
// 保证唯一


    public class func removeView(view: UIView) {
        let holder = ViewHolder(view)
        MMKeyBoardTouchManager.getInstance.listenQueue[view.MMgetAddressIdentifity()] = holder
    }
    public class func updateView() {
        MMKeyBoardTouchManager.getInstance.setupView()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
