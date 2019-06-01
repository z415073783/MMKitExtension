//
//  MMTopAlertView.swift
//  Odin-UC
//
//  Created by zlm on 2016/11/30.
//  Copyright © 2016年 yealing. All rights reserved.
//该类暂不使用

import UIKit

public typealias clickTopAlertFunc = () -> Void

public class MMTopAlertView: UIView {

    public var clickFunc: clickTopAlertFunc?
    
    @discardableResult class public func show(title: String) -> MMTopAlertView {
        let alert = MMTopAlertView()
        alert.accessibilityIdentifier = "alert"
        
        if let vc = kRootViewController as? UINavigationController,
            let superView = vc.topViewController?.view {
            superView.addSubview(alert)
            
            alert.snp.makeConstraints { (make) in
                make.left.right.equalTo(superView)
                make.top.equalTo(vc.navigationBar.snp.bottom)
                make.height.equalTo(44)
            }
            
            let label = MMLabel()
            label.accessibilityIdentifier = "label"
            label.text = title
            label.textAlignment = NSTextAlignment.center
            alert.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.edges.equalTo(alert)
            }
            
            alert.fadeInAction()
        }

        return alert
    }

    public func noticeCall(title: String, position: AlertNoButtonView_Position, supperView: UIView, block: clickTopAlertFunc?) {
        if block != nil {
            clickFunc = block
        }
        tag = MMAlertViewTag
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        supperView.addSubview(self)
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.7

        let titleLabel: MMLabel = MMLabel()
        titleLabel.tag = 1
        titleLabel.text = title
        titleLabel.font = UIFont.fontWithHelvetica(18)
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            MMLOG.debug("window.frame.size.width = \(supperView.frame.size.width)")
            make.width.lessThanOrEqualTo(supperView).multipliedBy(4.0/5.0)

        }
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = NSTextAlignment.center

        self.snp.makeConstraints { (make) in
            switch position {
            case AlertNoButtonView_Position.top:

                make.top.equalTo(supperView).offset(40)
                make.centerX.equalTo(supperView)
                break
            case AlertNoButtonView_Position.center:
                make.center.equalTo(supperView)
                make.left.lessThanOrEqualTo(supperView).offset(6)
                make.right.lessThanOrEqualTo(supperView).offset(-6)
                break
            case AlertNoButtonView_Position.bottom:
                make.bottom.equalTo(supperView).offset(-30)
                make.left.lessThanOrEqualTo(supperView).offset(6)
                make.right.lessThanOrEqualTo(supperView).offset(-6)
                break
            case AlertNoButtonView_Position.resident:
                break
            }
            make.width.equalTo(titleLabel).offset(16)
            make.height.equalTo(titleLabel).offset(20)
        }
        beginAction()
    }

    private func beginAction() {
        poppingAction()
        Timer.mm_scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] (_) in
            self?.endAction()
        })
    }
    private func endAction() {
        
        UIView.animate(withDuration: mm_kActionDuration, delay: 0, options: UIView.AnimationOptions.layoutSubviews, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] (_) in
            self?.removeFromSuperview()
        }
    }

    public func hide() {
        self.fadeOutAction()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.gray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

}
