//
//  UIViewController+Extension.swift
//  UME
//
//  Created by zlm on 16/7/20.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

public extension UIViewController {

    func mm_presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        present(viewControllerToPresent, animated: flag, completion: completion)
    }

    func mm_dismissViewControllerAnimated(_ flag: Bool, completion:@escaping (() -> Void)) {
        dismiss(animated: flag) {
            completion()
        }
    }
    /**
     注册滑动推出界面
     */
    func registerSlipeCloseView() {
        let gesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(slipeCloseView))
        view.addGestureRecognizer(gesture)
    }

    @objc func slipeCloseView(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.ended {
            let point: CGPoint = gesture.translation(in: view)
            if point.x < -80 && abs(point.x/point.y) > 3 {
                mm_dismissViewControllerAnimated(true, completion: {

                })
            }
        }
    }

    func mm_removeFromParentViewController() {
        removeFromParent()
    }
    /**
     添加右侧文字按钮
     必须是有导航条的controller才可调用
     
     - parameter sender: 文字
     - parameter action: 回调
     */
    func addRightTextButton(_ sender: String, action: Selector, _ titleColor: UIColor? = UIColor.white) {
        navigationItem.rightBarButtonItems = [createTextButton(sender, action: action, titleColor)]
//        navigationController?.topViewController?.navigationItem.rightBarButtonItem = createTextButton(sender, action: action, titleColor)
    }
    /**
     返回
     */
//    func addLeftReturnButton(_ state: NavigationbarReturnType = NavigationbarReturnType.blue) -> Void{
//        navigationController?.topViewController?.navigationItem.leftBarButtonItem = createImageButtonItem("NavigationBar_Return", action: #selector(closeCurrentController),direction:UIControlContentHorizontalAlignment.left)
//    }

    /**
     添加导航栏右侧按钮
     
     - parameter sender: 图片名称
     - parameter action: 按钮回调方法
     */
    func addRightImageButton(_ sender: String, action: Selector) {
        navigationItem.rightBarButtonItem = createImageButtonItem(sender, action: action, direction: UIControl.ContentHorizontalAlignment.right)
    }
    /**
     增加导航条右侧双按钮(图片+文字)
     
     - parameter textSender:  文字按钮名称
     - parameter textAction:  文字按钮回调
     - parameter imageSender: 图片按钮
     - parameter imageAction: 图片按钮回调
     */
    func addRightImageAndTextButton(_ textSender: String, textAction: Selector, imageSender: String, imageAction: Selector, _ titleColor: UIColor? = UIColor.white) {
        navigationItem.rightBarButtonItems = [createTextButton(textSender, action: textAction, titleColor), createImageButtonItem(imageSender, action: imageAction, direction: UIControl.ContentHorizontalAlignment.right)]
    }
    /**
     增加导航条右侧双按钮(图片+图片)
     
     - parameter firstImage:   firstImage description
     - parameter firstAction:  firstAction description
     - parameter secondImage:  secondImage description
     - parameter secondAction: secondAction description
     */
    func addRightbothImageButton(_ firstImage: String, firstAction: Selector, secondImage: String, secondAction: Selector) {
        navigationItem.rightBarButtonItems = [createImageButtonItem(firstImage, action: firstAction, direction: UIControl.ContentHorizontalAlignment.right), createImageButtonItem(secondImage, action: secondAction, direction: UIControl.ContentHorizontalAlignment.right)]
    }

    //创建文字按钮
    func createTextButton(_ sender: String, action: Selector, _ titleColor: UIColor? = UIColor.white, _ alignment: UIControl.ContentHorizontalAlignment = .right) -> UIBarButtonItem {
        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightButton.setTitle(sender, for: UIControl.State.normal)
        rightButton.mm_addtarget(self, action: action)
        rightButton.setTitleColor(titleColor, for: UIControl.State())
        rightButton.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        rightButton.setTitleColor(UIColor.textGrayColor, for: .disabled)
        rightButton.titleLabel?.font = UIFont.fontWithHelvetica(mm_kFontSizeLarge)
        let str: NSString = NSString(string: sender)
        var rect: CGRect = str.boundingRect(with: CGSize(width: 1000, height: 44), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.fontWithHelvetica(mm_kFontSizeLarge)], context: nil)
        if rect.size.width < 60 {
            rect.size.width = 60
        }
        rightButton.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: 44)
        rightButton.contentHorizontalAlignment = alignment
        rightButton.sizeToFit()
        let barBT: UIBarButtonItem = UIBarButtonItem.init(customView: rightButton)
        return barBT
    }
    //创建图片Item按钮
    func createImageButtonItem(_ sender: String, action: Selector, direction: UIControl.ContentHorizontalAlignment, size: CGSize = CGSize.zero) -> UIBarButtonItem {
        let button = createImageButton(sender, action: action, direction: direction, size: size)
        let barBT: UIBarButtonItem = UIBarButtonItem.init(customView: button)
        return barBT
    }


    func createImageButton(_ sender: String, action: Selector, direction: UIControl.ContentHorizontalAlignment, size: CGSize = CGSize.zero) -> UIButton {
        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightButton.contentHorizontalAlignment = direction
        rightButton.mm_addtarget(self, action: action)
        
        if let image = UIImage.init(named: sender) {
            rightButton.setImage(image, for: UIControl.State.normal)
            if size == CGSize.zero {
                rightButton.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            }else {
                rightButton.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            }
        }
        rightButton.sizeToFit()
        return rightButton
    }

    
}
