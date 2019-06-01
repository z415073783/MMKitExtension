//
//  MMTitleView.swift
//  Odin-UC
//
//  Created by zlm on 2016/11/29.
//  Copyright © 2016年 yealing. All rights reserved.
//

import UIKit

open class MMTitleView: UIView {

    public lazy var _title: MMLabel = {
        let label = MMLabel()
        label.accessibilityIdentifier = "_title"
        return label
    }()
    
    public lazy var _subtitle: MMLabel = {
        let label = MMLabel()
        label.accessibilityIdentifier = "_subtitle"
        return label
    }()

    public init(title: String, subTitle: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        initView(title: title, subTitle: subTitle)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    open func initView(title: String, subTitle: String) {
        let rect = title.boundingRect(with: CGSize(width: Int(kScreenWidth), height: 30), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.fontWithHelvetica(mm_kFontSizeLargest)], context: nil)
        _title.text = title
        _title.textColor = UIColor.white
        _title.font = UIFont.fontWithHelvetica(mm_kFontSizeLargest)
        self.addSubview(_title)

        _subtitle.text = subTitle
        _subtitle.textColor = UIColor.white
        _subtitle.font = UIFont.fontWithHelvetica(mm_kFontSizeSmall)
        self.addSubview(_subtitle)
        _title.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)

            if subTitle.count != 0 {
                make.top.equalTo(self.snp.top).offset(5)
            } else {
                make.centerY.equalTo(self)
                make.width.lessThanOrEqualTo(rect.size.width)
            }
        }
        _subtitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
