//
//  MMViewController.swift
//  UME
//
//  Created by zlm on 16/8/9.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit
//导航栏返回键类型
public enum MMNavigationbarTitleType {
    case white, blue, black
    public func getColor() -> UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .blue:
            return UIColor.blue
        }
    }
}
open class MMViewController: UIViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
        view.backgroundColor = UIColor.white
        edgesForExtendedLayout = []
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MMStatusBarManager.shared.clear()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MMKeyBoardTouchManager.updateView()
        
        viewDidAppear(animated, isFirstAppeared: !isViewAlreadyAppeared)
        
        if !isViewAlreadyAppeared {
            isViewAlreadyAppeared = true
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    open override var prefersStatusBarHidden: Bool {
        if let isHidden = MMStatusBarManager.shared.prefersStatusBarHidden {
            return isHidden
        }
        
        return super.prefersStatusBarHidden
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = MMStatusBarManager.shared.preferredStatusBarStyle {
            return style
        }
        
        return super.preferredStatusBarStyle
    }

    public private(set) var isViewAlreadyAppeared: Bool = false
    open func viewDidAppear(_ animated: Bool, isFirstAppeared: Bool) {
        
    }

    //从后台进入应用回调方法
    open func didEnterApplication() {

    }

    /// 自定义键盘躲避通知
    open func addKeyboardNotification() {
        //add observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    //关闭键盘躲避通知
    open func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc open func keyboardWillShow(notification: NSNotification) {
        guard let keyboardBound = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect else { return }
        view.sliderInAction(CGPoint(x: 0, y: -keyboardBound.size.height))
    }
    @objc open func keyboardDidShow(notification: NSNotification) {

    }
    @objc open func keyboardWillHide(notification: NSNotification) {
        view.sliderInAction(CGPoint(x: 0, y: 0))
    }
    @objc open func keyboardDidHide(notification: NSNotification) {
        
    }
    @objc open func keyboardWillChange(notification: NSNotification) {

    }

//    /**
//     注册导航栏双击手势:当存在UITableView时,双击导航条回到顶部(TableView必须为self.view的子类)
//     */
//    open func registerDoubleTapReturnTop() {
//        if _doubleTopTap == nil {
//            let doubleTopTap = UITapGestureRecognizer(target: self, action: #selector(moveToTop))
//            doubleTopTap.numberOfTapsRequired = 2
//            navigationController?.navigationBar.addGestureRecognizer(doubleTopTap)
//            _doubleTopTap = doubleTopTap
//        }
//    }
    /**
     移除双击返回置顶手势
     */
//    open func removeDoubleTapReturnTop() {
//        if let doubleTopTap = _doubleTopTap {
//            navigationController?.navigationBar.removeGestureRecognizer(doubleTopTap)
//            _doubleTopTap = nil
//        }
//    }

    /**
     实现方法:当存在UITableView时,双击导航条回到顶部
     */
    @objc open func moveToTop(_ gesture: UIGestureRecognizer) {
        onceMoveToTop(view)
    }
    open func onceMoveToTop(_ superView: UIView) {
        for item in superView.subviews {
            if (item as? UITableView) == nil {
                onceMoveToTop(item)
                continue
            }
            
            guard let tableView = item as? UITableView else { return }
            if tableView.visibleCells.count > 0 {
                for section in 0 ..< tableView.numberOfSections {
                    if tableView.numberOfRows(inSection: section) != 0 {
                        tableView.scrollRectToVisible(CGRect(x: 0,
                                                             y: 0,
                                                             width: tableView.frame.size.width,
                                                             height: tableView.frame.size.height),
                                                      animated: true)
                        return
                    }
                }

            }
        }
    }

    @objc open func closeCurrentController(_ sender: UIButton? = nil) {
        if let nc = navigationController {
            nc.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: {
            })
        }
    }

    @objc open func returnCurrentController(_ sender: UIButton? = nil) {
        _ = navigationController?.popViewController(animated:true)
    }
    //导航栏返回和关闭键
    open func addLeftReturnAndCloseButton(text: String, _ type: MMNavigationbarTitleType = MMNavigationbarTitleType.blue) {
        let backTitle = MMLanguage.localized("返回")
        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
//        rightButton.accessibilityIdentifier = "com.yealink.videophone:id/title_rl_left"
        rightButton.setTitle(backTitle, for: UIControl.State.normal)
        rightButton.titleLabel?.font = UIFont.fontWithHelvetica(mm_kFontSizeLarge)
        rightButton.setTitleColor(type.getColor(), for: .normal)
        let image: UIImage = UIImage.init(named: getReturnImageName(type: type))!
        rightButton.setImage(image, for: UIControl.State.normal)
//        rightButton.addtargetYL(self, action: #selector(closeCurrentController))
        rightButton.addTarget(self, action: #selector(closeCurrentController), for: .touchUpInside)
        var rect = backTitle.boundingRect(with: CGSize(width: 120, height: 44), options: NSStringDrawingOptions.usesFontLeading, attributes: [NSAttributedString.Key.font: rightButton.titleLabel?.font ?? mm_kFontSizeLarge], context: nil)
        rightButton.frame = CGRect(x: 0, y: 0, width: rect.size.width + 14, height: 44)
        rightButton.contentHorizontalAlignment = .left
        rightButton.sizeToFit()
        let barBT: UIBarButtonItem = UIBarButtonItem.init(customView: rightButton)

        let rightButton2 = UIButton.init(type: UIButton.ButtonType.custom)
//        rightButton2.accessibilityIdentifier = "com.yealink.videophone:id/title_rl_left2"
        rightButton2.setTitle(text, for: UIControl.State.normal)
//        rightButton2.addtargetYL(self, action: #selector(returnCurrentController))
        rightButton2.addTarget(self, action: #selector(returnCurrentController), for: .touchUpInside)
        rightButton2.setTitleColor(type.getColor(), for: UIControl.State.normal)
        rightButton2.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        rightButton2.titleLabel?.font = UIFont.fontWithHelvetica(mm_kFontSizeLarge)
        rect = text.boundingRect(with: CGSize(width: 1000, height: 44), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.fontWithHelvetica(mm_kFontSizeLarge)], context: nil)
        if rect.size.width<40 {
            rect.size.width = 40
        }
        rightButton2.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: 44)
        rightButton2.contentHorizontalAlignment = .left
        rightButton2.sizeToFit()
        let barBT2: UIBarButtonItem = UIBarButtonItem.init(customView: rightButton2)
        barBT.accessibilityIdentifier = "com.yealink.videophone:id/title_rl_left"
        barBT2.accessibilityIdentifier = "com.yealink.videophone:id/title_rl_leftClose"
        navigationItem.setLeftBarButtonItems([barBT, barBT2], animated: true)
    }

    //创建图片+文字返回按钮
    @discardableResult public func addLeftReturnAndTitleButton(_ type: MMNavigationbarTitleType = MMNavigationbarTitleType.blue, _ hideText: Bool = false, _ hideImage: Bool = false, _ titleText: String? = nil, _ imageName: String? = nil) -> UIButton {
        navigationItem.leftBarButtonItem = nil

        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
//        rightButton.accessibilityIdentifier = "com.yealink.videophone:id/title_rl_left"
        var newhideText = ""
        if hideText == false {
            newhideText = (titleText == nil ? MMLanguage.localized("Back") : titleText ?? "")
            rightButton.setTitle(newhideText, for: UIControl.State.normal)
            rightButton.titleLabel?.font = UIFont.fontWithHelvetica(mm_kFontSizeLarge)
            switch type {
            case .white:

                rightButton.setTitleColor(UIColor.white, for: .normal)
            case .black:

                rightButton.setTitleColor(UIColor.black, for: .normal)
            case .blue:
                rightButton.setTitleColor(UIColor.textBlueColor, for: .normal)
            }
        }
        if hideImage == false, let image = UIImage.init(named: imageName == nil ? getReturnImageName(type: type) : imageName ?? "" ) {
            rightButton.setImage(image, for: UIControl.State.normal)
        }
        rightButton.addTarget(self, action: #selector(closeCurrentController), for: .touchUpInside)
//        rightButton.addtargetYL(self, action: #selector(closeCurrentController))
       
        
//        var rect = newhideText.boundingRect(with: CGSize(width: 1000, height: 44), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.fontWithHelvetica(kFontSizeLarge)], context: nil)
//        if rect.size.width < 40 {
//            rect.size.width = 40
//        }
//
//        if let width = rightButton.imageView?.image?.size.width {
//            rect.size.width = rect.size.width + width
//        }
//        rightButton.frame = rect
        

        rightButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        rightButton.sizeToFit()
        let barBT: UIBarButtonItem = UIBarButtonItem.init(customView: rightButton)

        barBT.accessibilityIdentifier = "com.yealink.videophone:id/title_rl_left"
       navigationItem.leftBarButtonItem = barBT

        return rightButton
    }



    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
public extension MMViewController {

    func getReturnImageName(type: MMNavigationbarTitleType = MMNavigationbarTitleType.blue) -> String {
        var imageName = "NavigationBarReturn_White"
        switch type {
        case .black:
            imageName = "NavigationBarReturn_White"
        case .blue:
            imageName = "NavigationBarReturn_Blue"
        case .white:
            imageName = "NavigationBarReturn_White"
        }
        return imageName
    }
}
