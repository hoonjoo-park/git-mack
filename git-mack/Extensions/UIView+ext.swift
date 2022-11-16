//
//  UIView+ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/17.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
