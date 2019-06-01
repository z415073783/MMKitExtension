//
//  MMMenuView.swift
//  Odin-UC
//
//  Created by zlm on 2018/2/23.
//  Copyright © 2018年 yealing. All rights reserved.
//

import UIKit

public struct MMMenuModel {
    var iconImage: UIImage?
    var title = ""
    public init(iconImage: UIImage?, title: String) {
        self.iconImage = iconImage
        self.title = title
    }
}

public class MMMenuView: UIView {

    lazy var backgroundView: MMView = {
        let zView = MMView()
        zView.backgroundColor = UIColor.white
        zView.layer.cornerRadius = 4
        zView.layer.masksToBounds = true
        return zView
    }()


    func addRadiusShadow() {
        self.layoutIfNeeded()
        let subLayer = CALayer()
        subLayer.frame = backgroundView.frame
        subLayer.cornerRadius = 4
        subLayer.backgroundColor = UIColor.black.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = UIColor.black.cgColor
        subLayer.shadowOffset = CGSize(width: 2, height: 2)
        subLayer.shadowOpacity=0.3;
        subLayer.shadowRadius=3;
        self.layer.insertSublayer(subLayer, below: backgroundView.layer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initButton(image: UIImage, title: String) -> MMButton {
        let button = MMButton()
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }

    public func show(list: [MMMenuModel], superView: UIView, touchBlock: @escaping MMCallBlockFuncInt) {

        guard let rootView = kRootViewController?.view else {
            return
        }
        rootView.addSubview(self)
        rootView.bringSubviewToFront(self)
        snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        fadeInAction()

        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(superView.snp.bottom)
            make.right.equalToSuperview().offset(-6)
            make.width.greaterThanOrEqualTo(200)
            make.width.lessThanOrEqualToSuperview()
        }
        var tempButton: MMButton?
        for i in 0 ..< list.count {
            let item = list[i]
            let button = initButton(image: item.iconImage ?? UIImage(), title: item.title)
            backgroundView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.height.equalTo(50)
                if let tempButton = tempButton {
                    make.top.equalTo(tempButton.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }
                if list.count == i + 1 {
                    make.bottom.equalTo(backgroundView)
                }
                make.left.equalTo(backgroundView)
                make.right.equalTo(backgroundView).offset(-20)
            })
            tempButton = button

            if list.count != i + 1 {
                let lineView = UIView()
                lineView.backgroundColor = UIColor.gray
                backgroundView.addSubview(lineView)
                lineView.snp.makeConstraints { (make) in
                    make.height.equalTo(1)
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.top.equalTo(button.snp.bottom)
                }
            }
            button.setTouchUpInsideCallBack(block: { [weak self](sender) in
                touchBlock(i)
                self?.fadeOutAction()
            })
        }

        addRadiusShadow()
//        backgroundView.layer.cornerRadius = 4
//        backgroundView.clipsToBounds = true
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        fadeOutAction()
    }
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        fadeOutAction()
    }



}
