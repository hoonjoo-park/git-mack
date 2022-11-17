//
//  GMTabBarControllerViewController.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/16.
//

import UIKit

class GMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = GMColors.yellow
        UITabBar.appearance().unselectedItemTintColor = UIColor(r: 164, g: 168, b: 175)
        UITabBar.appearance().backgroundColor = GMColors.subNavy
        
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    
    func createSearchNC() -> UINavigationController {
        let checkoutVC = CheckoutVC()
        
        checkoutVC.tabBarItem = UITabBarItem(title: "Checkout", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        return UINavigationController(rootViewController: checkoutVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let starsVC = StarsVC()
        
        starsVC.tabBarItem = UITabBarItem(title: "Stars", image: UIImage(systemName: "star"), tag: 1)
        
        return UINavigationController(rootViewController: starsVC)
    }
}
