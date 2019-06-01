//
//  MMTextView.swift
//  UME
//
//  Created by zlm on 16/8/16.
//  Copyright © 2016年 yealink. All rights reserved.
//用于点击回收键盘

import UIKit

open class MMTextView: UITextView {
    
    public var maxCount: Int = Int.max

    public var placeholder: String? {
        didSet {
            placeholderTextView.text = placeholder
            updatePlaceholder()
        }
    }

    private lazy var placeholderTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.accessibilityIdentifier = "placeholderTextView"

        view.backgroundColor = .clear
        view.textColor = UIColor.gray
        view.isUserInteractionEnabled = false

        return view
    }()

    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textViewDidInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textViewDidInit()
    }

    open func textViewDidInit() {
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
        MMKeyBoardTouchManager.addView(view: self)
        textColor = UIColor.black

        addSubview(placeholderTextView)
        placeholderTextView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: UITextView.textDidChangeNotification,
                                               object: self)

        updatePlaceholder()
    }

    override open var text: String? {
        didSet {
            guard text != oldValue else { return }
            textDidChange(self)
        }
    }
}

private typealias __Actions = MMTextView
extension __Actions {

    public func updatePlaceholder() {
        placeholderTextView.font = font
        placeholderTextView.contentInset = contentInset
        placeholderTextView.textContainerInset = textContainerInset

        if let text = text {
            placeholderTextView.isHidden = text.count > 0
        } else {
            placeholderTextView.isHidden = true
        }
    }

    @objc func textDidChange(_ sender: Any) {
        if let _text = text, _text.count >= maxCount {
            text = _text.substring(to: _text.index(_text.startIndex,
                                                 offsetBy: maxCount))
        }
        
        updatePlaceholder()
    }
}
