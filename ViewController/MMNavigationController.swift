//
//  MMNavigationController.swift
//  UME
//
//  Created by zlm on 16/8/9.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

open class MMNavigationController: UINavigationController {

    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        // Do any additional setup after loading the view.
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MMStatusBarManager.shared.clear()
    }
    
    open override var prefersStatusBarHidden: Bool {
        if let isHidden = MMStatusBarManager.shared.prefersStatusBarHidden {
            return isHidden
        }
        
        if let controller = topViewController {
            return controller.prefersStatusBarHidden
        }
        
        return super.prefersStatusBarHidden
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = MMStatusBarManager.shared.preferredStatusBarStyle {
            return style
        }
        
        if let controller = topViewController {
            return controller.preferredStatusBarStyle
        }
        
        return super.preferredStatusBarStyle
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}

private typealias __Color = UINavigationController
extension __Color {
    
    public func setBarColor(_ color: UIColor) {
        let image = UIImage.imageWithColor(color: color)
        navigationBar.setBackgroundImage(image, for: .default)
    }
    
    public func setTitleColor(_ color: UIColor) {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
}
