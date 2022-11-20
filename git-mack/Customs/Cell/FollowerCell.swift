//
//  FollowerCell.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GMAvatarImageView(frame: .zero)
    let usernameLabel = GMTitleLabel(fontSize: 14, textAlign: .center, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(url: follower.avatarUrl)
    }
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
        
    }
}
