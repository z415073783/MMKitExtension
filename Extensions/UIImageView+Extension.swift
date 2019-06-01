//
//  UIImageView+Extension.swift
//  Odin-UC
//
//  Created by zlm on 2017/3/20.
//  Copyright © 2017年 yealing. All rights reserved.
//

import UIKit
public extension UIImageView {
    public func setRadius(radius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.white) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
