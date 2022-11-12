//
//  SceneDelegate.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
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
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        
        UITabBar.appearance().tintColor = GMColors.yellow
        UITabBar.appearance().unselectedItemTintColor = UIColor(r: 164, g: 168, b: 175)
        UITabBar.appearance().backgroundColor = GMColors.subNavy
        
        tabBar.viewControllers = [createSearchNC(), createFavoritesNC()]
        
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

