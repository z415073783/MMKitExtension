//
//  MMBlackViewController.swift
//  Odin-YMS
//
//  Created by zlm on 2017/4/21.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import UIKit

open class MMBlackViewController: MMPushViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    override func addLeftReturnButton() {
        addLeftReturnAndTitleButton(.white)
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setBarColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        navigationController?.setTitleColor(UIColor.white)
        navigationController?.navigationBar.isTranslucent = true
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent,
//                                               animated: true)
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
