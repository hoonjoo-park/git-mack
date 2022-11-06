//
//  UIViewController+ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import UIKit

extension UIViewController {
    func presentGMAlertOnMainThread(title: String, message: String) {
        DispatchQueue.main.async {
            let alertVC = GMAlertVC(title: title, message: message)
            
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            
            self.present(alertVC, animated: true)
        }
    }
}
