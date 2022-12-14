//
//  GMBodyLabel.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import UIKit

class GMBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlign: NSTextAlignment) {
        self.init(frame: .zero)
        
        self.font = UIFont.preferredFont(forTextStyle: .callout)
        self.textAlignment = textAlign
        self.textColor = .systemGray
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = -1
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
