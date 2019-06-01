//
//  MMBlueViewController.swift
//  Odin-YMS
//
//  Created by zlm on 2017/5/9.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import UIKit

open class MMBlueViewController: MMPushViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setBarColor(UIColor.mainColor)
        navigationController?.setTitleColor(UIColor.white)
        navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func addLeftReturnButton() {
        addLeftReturnAndTitleButton(.white)
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
