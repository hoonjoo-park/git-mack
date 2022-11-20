//
//  GMAvatarImageView.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import UIKit

class GMAvatarImageView: UIImageView {
    
    let defaultImage = GMImages.placeholderIcon
    let cache = NetworkManager.shared.cache

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = defaultImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    func downloadImage(url: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(imageUrl: url) ?? self.defaultImage
        }
    }
}
