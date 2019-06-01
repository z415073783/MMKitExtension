//
//  MMTextField.swift
//  UME
//
//  Created by zlm on 2016/10/28.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

public protocol MMTextFieldDelegate {
    func textfieldDidChange(sender: UITextField)
}
public enum MMTextFieldKeyType {
    case deleteBackward
}

open class MMTextField: UITextField {

    public var maxCount: Int = Int.max

    public var changeMMCallBlock: ((_ info: String)->Void)?

    public var touchkeyBlock: ((_ key: MMTextFieldKeyType, _ isTouchInside: Bool) -> Void)?

    var noRepeatText: Bool = true

    override open func draw(_ rect: CGRect) {
        // Drawing code
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    

        textFieldDidInit()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textFieldDidInit()
    }
    
    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }
//    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        super.canPerformAction(action, withSender: sender)
//
//        return true
//    }


    open func textFieldDidInit() {
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
        MMKeyBoardTouchManager.addView(view: self)
        super.delegate = self
        addTarget(self, action: #selector(textfieldDidChange(sender:)), for: UIControl.Event.allEditingEvents)
//        addTarget(self, action: #selector(textfieldDidChange(sender:)), for: UIControlEvents.allEvents)
        font = UIFont.fontWithHelvetica(14)
        textColor = UIColor.black
        clearButtonMode = .whileEditing

//        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(panGestureMethod(sender:)))
//        self.addGestureRecognizer(recognizer)
//        self.resignFirstResponder()

    }
//    @objc func panGestureMethod(sender: UILongPressGestureRecognizer) {
////        self.becomeFirstResponder()
//        UIMenuController.shared.setMenuVisible(true, animated: true)
//
//    }

    var isFristResponder = true
    public var tempText = ""
    @objc open func textfieldDidChange(sender: UITextField) {
        if let text = text {
            if text.count > maxCount {
                self.text = text.substring(to: text.index(text.startIndex, offsetBy: maxCount))
            }
        }
        guard let senderText = sender.text else { return }
        if tempText != senderText || noRepeatText == false {
            changeMMCallBlock?(senderText)
        }

        tempText = senderText
    }
    //是否开启边框警告
    open func setWarn(sender: Bool) {
        if sender {
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
        }
    }
    
    open override func deleteBackward() {
        super.deleteBackward()
        if let block = touchkeyBlock {
            block(MMTextFieldKeyType.deleteBackward, self.isTouchInside)
        }
    }
    
    // MARK: - 👉 Delegate
    open weak var originalDelegate: UITextFieldDelegate?
    
    open weak override var delegate: UITextFieldDelegate? {
        set {
            originalDelegate = newValue
        }
        get {
            return self
        }
    }

    // MARK: - 👉 Inset
    open var textInsetX: CGFloat = 0
    open var textInsetY: CGFloat = 0

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = bounds.insetBy(dx: textInsetX, dy: textInsetY)
        return super.textRect(forBounds: insetBounds)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = bounds.insetBy(dx: textInsetX, dy: textInsetY)
        return super.editingRect(forBounds: insetBounds)
    }
}

private typealias __UITextFieldDelegate = MMTextField
extension __UITextFieldDelegate: UITextFieldDelegate {

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if let returnValue = originalDelegate?.textFieldShouldBeginEditing?(textField) {
            return returnValue
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        originalDelegate?.textFieldDidEndEditing?(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let returnValue = originalDelegate?.textFieldShouldEndEditing?(textField) {
            return returnValue
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        originalDelegate?.textFieldDidEndEditing?(textField)
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        originalDelegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let returnValue = originalDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) {
            return returnValue
        }
        
        let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if newText.count > maxCount {
            return false
        }
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let returnValue = originalDelegate?.textFieldShouldClear?(textField) {
            return returnValue
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let returnValue = originalDelegate?.textFieldShouldReturn?(textField) {
            return returnValue
        }
        return true
    }
}
