//
//  UITableViewCell+Extension.swift
//  MMBaseFramework
//
//  Created by zlm on 2017/12/12.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Foundation
public extension UITableViewCell {
    func getTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }
    func getIndexPath() -> IndexPath? {
        return getTableView()?.indexPath(for: self)
    }
}
