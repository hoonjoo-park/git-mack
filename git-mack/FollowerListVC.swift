//
//  FollowerListVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/05.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 15, g: 24, b: 44)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
