//
//  InfoCountView.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

enum InfoType {
    case repos, gists, followers, following
}

class GMInfoCountView: UIView {
    var user: User!
    
    let symbolImageView = UIImageView()
    let titleLabel = GMTitleLabel(fontSize: 14, textAlign: .left, color: .white)
    let countLabel = GMTitleLabel(fontSize: 14, textAlign: .center, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        configureSymbolImageView()
        configureTitleLabel()
        configureCountLabel()
    }
    
    func configureSymbolImageView() {
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .white
        
        NSLayoutConstraint.activate([
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func configureCountLabel() {
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func set(type: InfoType, count: Int) {
        countLabel.text = String(count)
        
        switch type {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
    }
}
