//
//  UIViewController+ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentGMAlert(title: String, message: String) {
        let alertVC = GMAlertVC(title: title, message: message)
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overFullScreen
        
        present(alertVC, animated: true)
    }
    
    
    func showNotFoundView(message: String, view: UIView) {
        let notFoundView = GMNotFoundView(message: message)
        notFoundView.frame = view.bounds
        view.addSubview(notFoundView)
    }
    
    
    func presentSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
