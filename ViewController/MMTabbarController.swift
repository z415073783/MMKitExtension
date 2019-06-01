//  MMTabbarController.swift


import UIKit

open class MMTabbarController: UITabBarController {

    deinit {
        if !Thread.isMainThread {
            MMLOG.error("非主线程deinit UI: \(self)")
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        if !Thread.isMainThread {
            MMLOG.error("非主线程初始化UI: \(self)")
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
        
        if let controller = selectedViewController {
            return controller.prefersStatusBarHidden
        }
        
        return super.prefersStatusBarHidden
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = MMStatusBarManager.shared.preferredStatusBarStyle {
            return style
        }
        
        if let controller = selectedViewController {
            return controller.preferredStatusBarStyle
        }
        
        return super.preferredStatusBarStyle
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return selectedViewController
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

}
