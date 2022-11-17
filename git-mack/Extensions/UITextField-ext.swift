//
//  UITextField-ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/05.
//

import UIKit

extension UITextField {
    func addBottomBorder(color: UIColor, borderWidth: CGFloat) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: borderWidth)
        bottomBorder.backgroundColor = color.cgColor
        
        borderStyle = .none
        layer.addSublayer(bottomBorder)
    }
}


extension UITextField {
    func addLeftPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    
    func addRightPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
