//
//  StarCellTableViewCell.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/14.
//

import UIKit

class StarCell: UITableViewCell {
    
    static let reuseID = "StarCell"
    let avatarImageView = GMAvatarImageView(frame: .zero)
    let usernameLabel = GMTitleLabel(fontSize: 26, textAlign: .left, color: .white)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(user: Follower) {
        usernameLabel.text = user.login
        avatarImageView.downloadImage(imageUrl: user.avatarUrl)
    }
    
    private func configure() {
        self.backgroundColor = GMColors.subNavy
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 12
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
