//
//  MMWhiteViewController.swift
//  Odin-YMS
//
//  Created by zlm on 2017/4/21.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import UIKit

open class MMWhiteViewController: MMPushViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
//        addLeftReturnAndTitleButton(.blue)
        // Do any additional setup after loading the view.
    }
    override func addLeftReturnButton() {
        addLeftReturnAndTitleButton(.blue)
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setBarColor(UIColor.white)
        navigationController?.setTitleColor(UIColor.textBlackColor)
        navigationController?.navigationBar.isTranslucent = false
    }


    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
