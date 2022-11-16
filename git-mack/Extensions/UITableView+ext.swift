//
//  UITableView+ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/17.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
