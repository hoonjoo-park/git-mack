//
//  UIViewController+ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import UIKit

fileprivate var loadingContainerView: UIView!

extension UIViewController {
    func presentGMAlertOnMainThread(title: String, message: String) {
        DispatchQueue.main.async {
            let alertVC = GMAlertVC(title: title, message: message)
            
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        loadingContainerView = UIView(frame: view.bounds)
        view.addSubview(loadingContainerView)
        
        loadingContainerView.backgroundColor = .black
        loadingContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.3) { loadingContainerView.alpha = 0.8 }
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        loadingContainerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityIndicatorView.startAnimating()
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            loadingContainerView.removeFromSuperview()
            loadingContainerView = nil
        }
    }
    
    func showNotFoundView(message: String, view: UIView) {
        let notFoundView = GMNotFoundView(message: message)
        notFoundView.frame = view.bounds
        view.addSubview(notFoundView)
    }
}
