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
    let companyImageView = UIImageView()
    let companyLabel = GMSecondaryTitleLabel(fontSize: 18, color: .white)
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
        view.addSubview(companyImageView)
        view.addSubview(companyLabel)
        view.addSubview(bioLabel)
    }
    
    private func configureUIDataValues() {
        avatarImageView.downloadImage(imageUrl: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "이름 미등록"
        companyLabel.text = user.company ?? "직장 미등록"
        bioLabel.text = user.bio ?? "등록된 자기소개가 없습니다😥"
        bioLabel.textColor = .white
        
        companyImageView.image = UIImage(systemName: SFSymbols.company)
        companyImageView.tintColor = .white
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
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
            
            companyImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            companyImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: itemSpacing),
            companyImageView.widthAnchor.constraint(equalToConstant: 20),
            companyImageView.heightAnchor.constraint(equalToConstant: 20),
            
            companyLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            companyLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 5),
            companyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            companyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: itemSpacing),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

}
