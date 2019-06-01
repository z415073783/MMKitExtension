//
//  MMAlertNoButtonView.swift
//  UME
//
//  Created by zlm on 16/7/25.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

public let MMAlertViewTag = 10001  //提示框tag
public let MMAlertResidentViewTag = 10002 //常驻提示框tag

public enum AlertNoButtonView_Position {
    case top, center, bottom, resident //顶部显示,中间显示,底部显示
}

public class MMAlertNoButtonViewManager: NSObject {
    static public let getInstance = MMAlertNoButtonViewManager()
    public var residentView: MMAlertNoButtonView?
    public func removeView() {
        residentView?.endAction(block: { (_) in
        })
        MMAlertNoButtonViewManager.getInstance.residentView = nil
    }
    public func setText(sender: String) {
        residentView?.titlelb?.text = sender
    }
    public func setAttribute(sender: NSAttributedString?) {
        residentView?.titlelb?.attributedText = sender
    }
}

public class MMAlertNoButtonView: UIView {
    public typealias CallFunc = (_ info:Any?) -> Void
    var _callFunc: CallFunc?
    var _touchCallFunc: CallFunc?
    fileprivate var titlelb: MMTextView?

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// 初始化并显示提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - position: 显示位置
    ///   - block: 消失返回
    class public func show(_ title: String, position: AlertNoButtonView_Position = .center, block: CallFunc? = nil) {
        
        mm_executeOnMainThread {
            guard let window = MMWindowManager.shared.topestWindow() else { return }
            
            let alertView = window.viewWithTag(MMAlertViewTag)
            alertView?.accessibilityIdentifier = "alertView"
            if alertView != nil {
                guard let titleLabel: MMTextView = alertView?.viewWithTag(1) as? MMTextView else {
                    return
                }
                if titleLabel.text == title {
                    return
                }
            }
            MMAlertNoButtonView(title: title,
                                position: position,
                                block: block)
        }
    }

   



    @discardableResult fileprivate init(title: String,
                                        position: AlertNoButtonView_Position,
                                        attribute:NSAttributedString? = nil,
                                        touchBlock: CallFunc? = nil,
                                        block: CallFunc?) {
        
        if block != nil {
            _callFunc = block
        }
        if touchBlock != nil {
            _touchCallFunc = touchBlock
        }
        super.init(frame:CGRect(x: 0, y: 0, width: 600, height: 1000))
        
        guard let window = MMWindowManager.shared.topestWindow() else { return }
        
        tag = MMAlertViewTag
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        window.addSubview(self)
        layer.cornerRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.7

        let titleLabel: MMTextView = MMTextView()
//        titleLabel.addGestureRecognizer(UILongPressGestureRecognizer(target: self,
//                                                                     action: #selector(longPress(gestureRecognizer:))))
//        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self,
//                                                                     action: #selector(longPress(gestureRecognizer:))))
        titleLabel.tag = 1
        titleLabel.delegate = self
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.isScrollEnabled = false
        if attribute != nil {
            titleLabel.attributedText = attribute
        }else {
            titleLabel.text = title
        }
        titleLabel.font = UIFont.fontWithHelvetica(mm_kFontSizeMedium)
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)

        titleLabel.snp.remakeConstraints { (make) in
            make.center.equalToSuperview()
            MMLOG.debug("window.frame.size.width = \(window.frame.size.width)")
            make.width.lessThanOrEqualTo(kScreenWidth * 4 / 5)
        }

        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.isEditable = false
        snp.makeConstraints { (make) in
            switch position {
                case AlertNoButtonView_Position.top:
                    if let residentView = MMAlertNoButtonViewManager.getInstance.residentView {
                        make.top.equalTo(residentView.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(window.snp.top).offset(65)
                    }
                    make.centerX.equalTo(window)
                    make.width.equalTo(titleLabel).offset(20)
                    break
                case AlertNoButtonView_Position.center:
                    make.center.equalTo(window)
                    make.width.equalTo(titleLabel).offset(20)
                    break
                case AlertNoButtonView_Position.bottom:
                    make.bottom.equalTo(window).offset(-20)
                    make.left.equalTo(window).offset(6)
                    make.right.equalTo(window).offset(-6)
                    break
                case AlertNoButtonView_Position.resident:
                    MMAlertNoButtonViewManager.getInstance.residentView = self
                    tag = MMAlertResidentViewTag
                    make.top.equalTo(window.snp.top).offset(65)
                    make.centerX.equalTo(window)
                    make.width.equalTo(titleLabel).offset(20)

                    break
            }

            make.height.equalTo(titleLabel).offset(20)
        }
        titlelb = titleLabel
//        NSAttributedStringKey.link
        beginAction(position: position)
    }


    private func beginAction(position: AlertNoButtonView_Position) {

        poppingAction()
        if position == .resident {
            return
        }

        Timer.mm_scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] (_) in
            self?.endAction()
        })
    }
    fileprivate func endAction(block: CallFunc? = nil) {
        UIView.animate(withDuration: mm_kActionDuration, delay: 0, options: UIView.AnimationOptions.layoutSubviews, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] (_) in
            self?.removeFromSuperview()
            block?(nil)
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _callFunc?(nil)
    }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */


}
typealias _TextViewDelegate = MMAlertNoButtonView
extension _TextViewDelegate: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        _touchCallFunc?(characterRange)
        return false
    }
    
}

