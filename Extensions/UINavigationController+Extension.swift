//
//  UINavigationController+Extension.swift
//  UME
//
//  Created by zlm on 16/7/21.
//  Copyright © 2016年 yealink. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    func MMpushViewController(_ viewController: UIViewController, animated: Bool) {
        if ((topViewController?.MMclassName() == viewController.MMclassName()) == false) {
            viewController.hidesBottomBarWhenPushed = true
            pushViewController(viewController, animated: animated)
        }
    }

    func MMpushViewControllerFromTop(_ viewController: UIViewController, animated: Bool) {
        if ((topViewController?.MMclassName() == viewController.MMclassName()) == false) {
            let transition = CATransition.init()
            transition.duration = MMkNavigationPushActionDuration
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromBottom
            self.view.layer.add(transition, forKey: "")
            viewController.hidesBottomBarWhenPushed = true
            pushViewController(viewController, animated: animated)
        }
    }
    /* The name of the transition. Current legal transition types include
     * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */
    enum CustomAnimationPushVCType: String {
        case fade = "fade", moveIn = "moveIn", push = "push", reveal = "reveal"

    }
    func pushCustomAnimationViewController(_ viewController: UIViewController, animationType: CustomAnimationPushVCType) {
//        MMLOG.debug("viewController.className() = \(viewController.className())")

        if ((topViewController?.MMclassName() == viewController.MMclassName()) == false) {
            viewController.hidesBottomBarWhenPushed = true
//            let transition = CATransition()
//            transition.duration = kNavigationPushActionDuration
//            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//            transition.type = animationType.rawValue
//            view.layer.add(transition, forKey: nil)
            pushViewController(viewController, animated: false)
        }

    }
    func popCustomAnimation(animationType: CustomAnimationPushVCType) {

//        let transition = CATransition()
//        transition.duration = kNavigationPushActionDuration
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transition.type = animationType.rawValue
//        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
//        UIView.transition(with: view, duration: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//            self.popViewController(animated: false)
//        }) { (finish) in
//
//        }

    }

    @discardableResult
    func MMpopViewControllerAnimated(_ animated: Bool) -> UIViewController? {
        return popViewController(animated: animated)
    }
    //推出到起始页
    func MMpopToRootViewControllerAnimated(_ animated: Bool) -> [UIViewController]? {
//
        let list = navigationController?.popToRootViewController(animated: animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
        return list
    }
    //结束回调

}
