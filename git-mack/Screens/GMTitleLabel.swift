//
//  GMTitleLabel.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import UIKit

class GMTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat, textAlign: NSTextAlignment, color: UIColor?) {
        super.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textAlignment = textAlign
        self.textColor = color ?? UIColor.black
        
        configure()
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        minimumScaleFactor = 0.9
        translatesAutoresizingMaskIntoConstraints = false
    }
}
