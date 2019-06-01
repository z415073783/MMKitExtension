//
//  MMTouchView.swift
//  Odin-YMS
//
//  Created by zlm on 2017/9/22.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import UIKit

open class MMTouchView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var _MMCallBlock:((_ sender: UIView) -> Void)?

    private var _tapGesture: UITapGestureRecognizer?

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //添加touch手势
    public func addtarget(block: @escaping (_ sender: UIView) -> Void) {
        _MMCallBlock = block
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for item in touches {
            let point = item.location(in: self)
            if self.isInside(point: point) {
                guard let block = _MMCallBlock else {
                    return
                }
                block(self)
            }
            break
        }
    }
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

    }
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

    }
}
