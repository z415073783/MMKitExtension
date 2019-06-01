//
//  MMPushViewController.swift
//  UME
//
//  Created by zlm on 16/8/9.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

open class MMPushViewController: MMBaseViewController, UIGestureRecognizerDelegate {
    
    var _leftReturnButton: UIButton?
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftReturnButton()
        if let _navigationController = navigationController {
            //重新注册左侧滑动手势
            weak var weakSelf = self
            _navigationController.interactivePopGestureRecognizer?.delegate = weakSelf
        }
        
        // Do any additional setup after loading the view.
        
        //         Timer.scheduledTimerYL(withTimeInterval: 5, repeats: false, block: {(Any) -> Void in
        //            NotificationCenter.default.post(name: NSNotification.Name.init(kNewMessageComeOnNotification), object: nil)
        //
        //        })
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        hidesBottomBarWhenPushed = true
        
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //开启滑动返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        tabBarController?.tabBar.isHidden = true
        
        guard let title = self.title else {
            return
        }
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let title = self.title else {
            return
        }
    }
    
    deinit {
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
