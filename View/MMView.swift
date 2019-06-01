//
//  MMView.swift
//  Odin-UC
//
//  Created by zlm on 2016/11/21.
//  Copyright © 2016年 yealing. All rights reserved.
//

import UIKit
//渐变类型
enum BasicViewGradientType {
    case none, line, radius
}
open class MMView: UIView {

    private var _gradientType: BasicViewGradientType = .none
    private var _gradientColors: [CGFloat] = []
    private var _gradientfromPoint = CGPoint.zero
    private var _gradienttoPoint = CGPoint.zero

//  fromPoint和toPoint范围为 0~1
    public func setLineGradient(beginColor: UIColor, endColor: UIColor,fromPoint: CGPoint, toPoint: CGPoint) {
        guard let beginList = beginColor.cgColor.components, let endList = endColor.cgColor.components else { return }
        _gradientColors = beginList + endList
        _gradientfromPoint = fromPoint
        _gradienttoPoint = toPoint
        _gradientType = .line
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        if _gradientType == .line {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let locations: [CGFloat] = [0.0, 1.0]
            let start = CGPoint(x: _gradientfromPoint.x * rect.size.width, y: _gradientfromPoint.y * rect.size.height)
            let end = CGPoint(x: _gradienttoPoint.x * rect.size.width, y: _gradienttoPoint.y * rect.size.height)

            guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: _gradientColors, locations: locations, count: locations.count) else { return }
            context.drawLinearGradient(gradient, start: start, end: end, options: .drawsBeforeStartLocation)
        }
    }

    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        removeTargetMM()
        NotificationCenter.default.removeObserver(self)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        viewDidInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        viewDidInit()
    }
    
    open func viewDidInit() {
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
    }

    var _tapGesture: UITapGestureRecognizer?

    //添加touch手势
    open func addtargetMM(_ target: AnyObject?, action: Selector) {
        removeTargetMM()
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapGesture)
        _tapGesture = tapGesture
    }

    open func removeTargetMM() {
        if let tapGesture = _tapGesture {
            removeGestureRecognizer(tapGesture)
            _tapGesture = nil
        }
    }

}
