//
//  GMDataLoadingVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/17.
//

import UIKit

class GMDataLoadingVC: UIViewController {

    var loadingContainerView: UIView!
    
    func showLoadingView() {
        loadingContainerView = UIView(frame: view.bounds)
        view.addSubview(loadingContainerView)
        
        loadingContainerView.backgroundColor = .black.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.3) { self.loadingContainerView.alpha = 0.8 }
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        loadingContainerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: loadingContainerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: loadingContainerView.centerYAnchor),
        ])
        
        activityIndicatorView.startAnimating()
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.loadingContainerView.removeFromSuperview()
            self.loadingContainerView = nil
        }
    }

}
