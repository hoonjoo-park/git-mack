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
    let usernameLabel = GMTitleLabel(fontSize: 21, textAlign: .left, color: .white)
    let padding: CGFloat = 12

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureAvatarImageView()
        configureUsernameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(user: Follower) {
        usernameLabel.text = user.login
        
        NetworkManager.shared.downloadImage(imageUrl: user.avatarUrl) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    func configureUI() {
        self.backgroundColor = GMColors.subNavy
        addSubviews(avatarImageView, usernameLabel)
        accessoryType = .disclosureIndicator
    }
    
    func configureAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func configureUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
