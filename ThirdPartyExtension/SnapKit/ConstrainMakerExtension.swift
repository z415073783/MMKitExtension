//
//  ConstrainMaker.swift
//  MMBaseFramework
//
//  Created by yealink-dev on 2018/7/3.
//  Copyright © 2018年 Yealink. All rights reserved.
//

import Foundation
import SnapKit

public extension ConstraintView {
    public var snpSafe: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension ConstraintMaker {
    //距离顶部(自动适配安全距离) 传入控制器的view
    public func safeAreaToTop(_ view: UIView,_ offset: Double = 0) {
        if #available(iOS 11.0, *) {
            top.equalTo(view.safeAreaLayoutGuide).offset(offset)
        } else {
            top.equalTo(view).offset(20 + offset)
        }
    }
    //距离底部(自动适配安全距离) 传入控制器的view
    public func safeAreaToBottom(_ view: UIView,_ offset: Double = 0) {
        if #available(iOS 11.0, *) {
            bottom.equalTo(view.safeAreaLayoutGuide).offset(offset)
        } else {
            bottom.equalTo(view).offset(offset)
        }
    }

    public func safeAreaLeftMargin(_ view: UIView, _ offset: CGFloat = 0) {
        if #available(iOS 11.0, *) {
            left.equalTo(view.safeAreaLayoutGuide).offset(offset)
        } else {
            left.equalTo(view).offset(offset)
        }
    }
    public func safeAreaRightMargin(_ view: UIView, _ offset: CGFloat = 0) {
        if #available(iOS 11.0, *) {
            right.equalTo(view.safeAreaLayoutGuide).offset(offset)
        } else {
            right.equalTo(view).offset(offset)
        }
    }
}
