//
//  MMBaseViewController.swift
//  UME
//
//  Created by zlm on 16/8/9.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

//导航栏颜色类型
public enum NavigationBarColorType {
    case main, white, black
}

open class MMBaseViewController: MMViewController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logTitle()
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logTitle()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logTitle()
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logTitle()
    }
    func logTitle(file: String = #file, function: String = #function) {
        MMLOG.info("logTitle: file = \(file), function = \(function)")
        var finalTitle: String?
        if let _title = title {
            finalTitle = _title
        } else if let tabbarTitle = tabBarItem.title {
            finalTitle = tabbarTitle
        } else if let navTitle = navigationItem.title {
            finalTitle = navTitle
        }
        if let _finalTitle = finalTitle {
            MMLOG.info("VC Title = \(String(describing: _finalTitle))")
        }
    }


    /**
     返回
     */
    func addLeftReturnButton() -> Void{
        MMLOG.info("重置返回按钮")
        navigationItem.leftBarButtonItems = []
    
        navigationItem.setLeftBarButton(createImageButtonItem("nav_icon_back_normal", action: #selector(closeCurrentController),direction:UIControl.ContentHorizontalAlignment.left, size: CGSize(width: 100, height: 44)), animated: true)
        if let btn = navigationItem.leftBarButtonItem?.customView as? UIButton {
            btn.setTitle(MMLanguage.localized("返回"), for: UIControl.State.highlighted)
        }
    }
    //左侧关闭按钮
    func addLeftCloseButton() -> Void {
        navigationItem.leftBarButtonItem = createImageButtonItem("General_CloseReturn", action: #selector(closeCurrentController),direction:UIControl.ContentHorizontalAlignment.left)
    }

    //左侧自定义文字按钮
    func addLeftTitleButton(title: String, titleColor: UIColor) -> Void {
        navigationItem.leftBarButtonItem = createTextButton(MMLanguage.localized( title), action:
            #selector(closeCurrentController), titleColor, .left)
    }

    open func changeNavigationBarColor(type: NavigationBarColorType) {
        let image: UIImage?
        switch type {
        case .main:
            let color = UIColor.mainColor
            image = UIImage.imageWithColor(color: color)
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        case .white:
            let color = UIColor.white
            image = UIImage.imageWithColor(color: color)
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textBlackColor]
        case .black:
            let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)  
            image = UIImage.imageWithColor(color: color)
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        guard let _image = image else {
            return
        }
        self.navigationController?.navigationBar.setBackgroundImage(_image, for: .default)
    }
}



