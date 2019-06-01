//
//  MMBaseAlertView.swift
//  UME
//
//  Created by zlm on 16/7/21.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit
public class AlertWindowManager: NSObject {
    static let shared = AlertWindowManager()
    var window: UIWindow?
    public class func showWindow() -> UIWindow? {
        if shared.window == nil {
//            MMBaseKeyboardManager.shared().resignKeyboard()
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert
            win.makeKeyAndVisible()
            shared.window = win
        } else {
            MMLOG.error("alert window未置空")
        }
        return shared.window
    }
    public class func hideWindow() {
        if shared.window != nil {
            shared.window?.rootViewController = nil
            shared.window?.resignKey()
            shared.window?.removeFromSuperview()
            shared.window = nil
        }
    }

    class func getView() -> UIView? {
        return shared.window?.rootViewController?.view
    }


}

public class MMAlertController: UIAlertController {
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        AlertWindowManager.hideWindow()
//        MMBaseKeyboardManager.shared().isEnable = true
    }
}


public class MMAlertView: NSObject {


    /// 提示框/下拉框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - params: 按钮列表
    ///   - cancel: 取消按钮
    ///   - preferredStyle: UIAlertControllerStyle
    ///   - target: UIViewController
    ///   - superView: 当为actionSheet时,必填
    ///   - block: 回调 tag根据params各元素下标一致,cancel的tag为prams.count
    @discardableResult
    public static func show(_ title: String?, message: String?, params: [String]?, cancel: String?, preferredStlye: UIAlertController.Style, target: UIViewController? = nil, superView: UIView? = nil, block: @escaping ((_ tag: Int) -> Void)) -> UIAlertController {

//        if let cancel = cancel, let count = params?.count, count <= 1 {
//            let titleLabel = UILabel()
//            titleLabel.font = UIFont.fontWithHelvetica(17)
//            titleLabel.text = message
//            MMAlertModuleView(title: title, cancel: cancel, certain: params?.first, modules: [titleLabel], block: { (index) in
//
//            })
//            return
//        }

//        let target = AlertWindowManager.shared.rootVC
//        MMBaseKeyboardManager.shared().isEnable = false
        let alertC = MMAlertController(title: title, message: message, preferredStyle: preferredStlye)
        if let params = params {
            for i in 0 ..< params.count {
                let paramAction: UIAlertAction = UIAlertAction(title: params[i], style: UIAlertAction.Style.default) { (action) in
                    block(i)
                    AlertWindowManager.hideWindow()
//                    MMBaseKeyboardManager.shared().isEnable = true
                }
//                paramAction.setValue(MMColor.textBlackColorMM, forKey:"titleTextColor")
                alertC.addAction(paramAction)
            }
        }

        if cancel != nil {
            let cancelAction: UIAlertAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel) { (action) in
                block(params?.count ?? 0)
                AlertWindowManager.hideWindow()
//                MMBaseKeyboardManager.shared().isEnable = true
            }
            cancelAction.setValue(UIColor.black, forKey:"titleTextColor")
            alertC.addAction(cancelAction)
        }

        if let popoverC = alertC.popoverPresentationController,
            let sourceView = superView {
            popoverC.sourceView = sourceView
            popoverC.sourceRect = sourceView.bounds
            popoverC.permittedArrowDirections = UIPopoverArrowDirection.any
        }

        if let message = message {
            let messageStr = NSMutableAttributedString(string: message)
            messageStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.fontWithHelvetica(15)], range: NSMakeRange(0, message.count))
//            if (alertC.value(forKey: "attributedMessage") != nil) {
                alertC.setValue(messageStr, forKey: "attributedMessage")
//            }
        }


        if let target = target {
            target.present(alertC, animated: true, completion: {
            })
        } else {
            AlertWindowManager.showWindow()?.rootViewController?.present(alertC, animated: true) {
            }
        }

        if preferredStlye == UIAlertController.Style.actionSheet {
            alertC.view.layoutIfNeeded()
        }
        
        return alertC
    }


    /// 初始化并显示提示框,
    ///
    /// - Parameters:
    ///   - title: 标题 可选
    ///   - message: 内容 可选
    ///   - param1: 按钮1 可选
    ///   - param2: 按钮2 可选
    ///   - cancel: 关闭按钮 可选
    ///   - preferredStyle: 提示框风格
    ///   - target: 视图控制器 传入需要调用该方法的本视图控制器
    ///   - superView: 当preferredStyle设为actionSheet时,需要传入指定视图 可选
    ///   - block: 返回块 
    public static func Show(_ title: String?, message: String?, param1: String?, param2: String?, cancel: String?, preferredStyle: UIAlertController.Style, target: UIViewController, superView: UIView? = nil, block:@escaping ((_ action: UIAlertAction) -> Void)) {





//        MMBaseKeyboardManager.shared().isEnable = false
        let alertC = MMAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if param1 != nil {
            let param1Action: UIAlertAction = UIAlertAction(title: param1, style: UIAlertAction.Style.default) { (action) in
                block(action)
//                MMBaseKeyboardManager.shared().isEnable = true
            }
            param1Action.setValue(UIColor.black, forKey:"titleTextColor")
            alertC.addAction(param1Action)

        }
        if param2 != nil {
            let param2Action: UIAlertAction = UIAlertAction(title: param2, style: UIAlertAction.Style.default) { (action) in
                block(action)
//                MMBaseKeyboardManager.shared().isEnable = true
            }
            param2Action.setValue(UIColor.black, forKey:"titleTextColor")
            alertC.addAction(param2Action)
        }
        if cancel != nil {
            let param3Action: UIAlertAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel) { (action) in
                block(action)
//                MMBaseKeyboardManager.shared().isEnable = true
            }
            param3Action.setValue(UIColor.black, forKey:"titleTextColor")
            alertC.addAction(param3Action)
        }
        
        if let popoverC = alertC.popoverPresentationController,
            let sourceView = superView {
            popoverC.sourceView = sourceView
            popoverC.sourceRect = sourceView.bounds
            popoverC.permittedArrowDirections = UIPopoverArrowDirection.any
        }

        target.present(alertC, animated: true) {

        }
        if preferredStyle == UIAlertController.Style.actionSheet {
            alertC.view.layoutIfNeeded()
        }

    }

}
