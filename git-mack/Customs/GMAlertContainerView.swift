//
//  GMAlertContainerView.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/16.
//

import UIKit

class GMAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        backgroundColor = GMColors.subNavy
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 290),
            self.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}
