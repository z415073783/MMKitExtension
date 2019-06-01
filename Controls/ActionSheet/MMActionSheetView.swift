//
//  MMActionSheetView.swift
//  Odin-UC
//
//  Created by zlm on 2018/1/29.
//  Copyright © 2018年 yealing. All rights reserved.
//

import UIKit

public class MMActionSheetView: MMView {

    var touchBlock: MMCallBlockFuncInt?
    lazy var backgroundView: MMView = {
        let zView = MMView()
        zView.backgroundColor = UIColor.white
        return zView
    }()
    lazy var blackBackgroundView: UIView = {
        let zView = MMView()
        zView.backgroundColor = UIColor.init(MMRed: 0.5, MMGreen: 0.5, MMBlue: 0.5, MMAlpha: 0.5)
        return zView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public class func show(list: [String], title: String? = nil, cancel: String? = MMLanguage.localized("Cancel"), MMCallBlock: @escaping MMCallBlockFuncInt) {
        let `self` = MMActionSheetView()
        
        guard let rootVC = kRootViewController, let window = kAppWindow else { return }
        window.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.addSubview(self.blackBackgroundView)
        self.blackBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.blackBackgroundView.fadeInAction()
        self.touchBlock = MMCallBlock
        self.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.bottom) //默认在屏幕外
        }
        var safeAreaOffset = 0
        if #available(iOS 11.0, *) {
            safeAreaOffset = Int(rootVC.view.safeAreaInsets.bottom)
        }
        let countSize = list.count * 50
        let cancelSize = (cancel == nil ? 0 : 60)
        let titleSize = (title == nil ? 0 : 50)
        self.backgroundView.sliderInActionWithTime(CGPoint(x: 0, y: -(countSize + cancelSize + titleSize + safeAreaOffset)))
        var tempBtn: MMButton?
        if let title = title {
            let button = MMButton()
            self.setButtonProperty(button: button)
            self.backgroundView.addSubview(button)
            button.setTitle(title, for: .normal)
            button.isEnabled = false
            button.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                if let tempBtn = tempBtn {
                    make.top.equalTo(tempBtn.snp.bottom)
                } else {
                    make.top.equalTo(self.backgroundView)
                }
                make.height.equalTo(50)
            })
            tempBtn = button
        }

        for i in 0 ..< list.count {
            let item = list[i]
            let button = MMButton()
            self.setButtonProperty(button: button)
            self.backgroundView.addSubview(button)
            button.setTitle(item, for: .normal)
            button.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                if let tempBtn = tempBtn {
                    make.top.equalTo(tempBtn.snp.bottom)
                } else {
                    make.top.equalTo(self.backgroundView)
                }
                make.height.equalTo(50)
            })
            button.setTouchUpInsideCallBack(block: { [weak self](sender) in
                guard let `self` = self else { return }
                MMCallBlock(i)
                self.hidden()
            })
            tempBtn = button
        }

        if let cancel = cancel {
            let button = MMButton()
            self.setButtonProperty(button: button)
            self.backgroundView.addSubview(button)
            button.setTitle(cancel, for: .normal)
            button.setTouchUpInsideCallBack(block: { [weak self](sender) in
                guard let `self` = self else { return }
                MMCallBlock(list.count)
                self.hidden()
            })
            button.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                if let tempBtn = tempBtn {
                    make.top.equalTo(tempBtn.snp.bottom).offset(10)
                } else {
                    make.top.equalTo(self.backgroundView)
                }
                make.height.equalTo(50)

                make.safeAreaToBottom(self.backgroundView, Double(-safeAreaOffset))

            })

        } else {
            tempBtn?.snp.updateConstraints({ (make) in
                make.safeAreaToBottom(self.backgroundView)
            })
        }
    }
    func addLineView(button: UIView) {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.gray
        button.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }

    func setButtonProperty(button: MMButton) {
        button.setBackgroundColor(UIColor.white, for: .normal)
        button.setBackgroundColor(UIColor.white, for: .highlighted)
        button.setBackgroundColor(UIColor.white, for: .disabled)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.black, for: .highlighted)
        button.setTitleColor(UIColor.gray, for: .disabled)
        addLineView(button: button)
    }

    public func hidden() {
        backgroundView.sliderOutAction {[weak self] in
            self?.removeFromSuperview()
        }
        blackBackgroundView.fadeOutAction()
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        hidden()
    }
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        hidden()
    }

}

