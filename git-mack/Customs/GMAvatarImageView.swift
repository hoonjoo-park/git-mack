//
//  GMAvatarImageView.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import UIKit

class GMAvatarImageView: UIImageView {
    
    let defaultImage = UIImage(named: "place-holder")!

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
    
}
