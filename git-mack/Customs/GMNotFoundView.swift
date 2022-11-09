//
//  GMNotFoundView.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/09.
//

import UIKit

class GMNotFoundView: UIView {
    let messageLabel = GMTitleLabel(fontSize: 21, textAlign: .center, color: .white)
    let notFoundImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(notFoundImageView)
        addSubview(messageLabel)
        
        notFoundImageView.image = UIImage(named: "github-square-3d")
        notFoundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.heightAnchor.constraint(equalToConstant: 150),
            
            notFoundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120),
            notFoundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            notFoundImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            notFoundImageView.heightAnchor.constraint(equalTo: notFoundImageView.widthAnchor),
        ])
    }

}
