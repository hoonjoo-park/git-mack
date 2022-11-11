//
//  ProfileInfoVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

class GMProfileInfoVC: UIViewController {
    var user: User!
    
    let avatarImageView = GMAvatarImageView(frame: .zero)
    let usernameLabel = GMTitleLabel(fontSize: 34, textAlign: .left, color: .white)
    let nameLabel = GMSecondaryTitleLabel(fontSize: 18, color: .white)
    let locationImageView = UIImageView()
    let locationLabel = GMSecondaryTitleLabel(fontSize: 18, color: .white)
    let bioLabel = GMBodyLabel(textAlign: .left)
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureUI()
        configureUIDataValues()

    }
    
    private func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    private func configureUIDataValues() {
        avatarImageView.downloadImage(imageUrl: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "이름 미등록"
        locationLabel.text = user.location ?? "위치 미등록"
        bioLabel.text = user.bio ?? "등록된 자기소개가 없습니다😥"
        bioLabel.textColor = .white
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .white
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureUI() {
        let padding: CGFloat = 20
        let itemSpacing: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: itemSpacing),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: itemSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: itemSpacing),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: itemSpacing),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

}
