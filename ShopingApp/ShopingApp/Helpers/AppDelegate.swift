//
//  AppDelegate.swift
//  ShopingApp
//
//  Created by Abduraxmon on 19/03/23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var registered = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow()
        
        if registered {
            let mainPageVC = MainPageVC(nibName: "MainPageVC", bundle: nil)
            let likedProductsVC = LikedProductsVC(nibName: "LikedProductsVC", bundle: nil)
            let savedProductsVC = SavedProductsVC(nibName: "SavedProductsVC", bundle: nil)
            let commentVC = CommentVC(nibName: "CommentVC", bundle: nil)
            let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
            let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil)
            
            let item1 = UITabBarItem()
            let item2 = UITabBarItem()
            let item3 = UITabBarItem()
            let item4 = UITabBarItem()
            let item5 = UITabBarItem()
            
            item1.image = UIImage(systemName: "house")
            item2.image = UIImage(systemName: "heart")
            item3.image = UIImage(systemName: "cart")
            item4.image = UIImage(named: "Vector")
            item5.image = UIImage(systemName: "person")
            
            mainPageVC.tabBarItem = item1
            likedProductsVC.tabBarItem = item2
            savedProductsVC.tabBarItem = item3
            commentVC.tabBarItem = item4
            profileVC.tabBarItem = item5
            
            let tabBarController = UITabBarController()
            tabBarController.tabBar.tintColor = #colorLiteral(red: 0.5258911848, green: 0.5270001292, blue: 0.657535553, alpha: 1)
            tabBarController.tabBar.backgroundColor = .white
            tabBarController.tabBar.layer.masksToBounds = true
            tabBarController.tabBar.isTranslucent = true
            tabBarController.tabBar.barStyle = .default
            tabBarController.tabBar.layer.cornerRadius = 20
            tabBarController.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            tabBarController.viewControllers = [mainPageVC, likedProductsVC, savedProductsVC, commentVC, profileVC, productDetailVC]
        } else {
            let signInVC = SignInVC(nibName: "SignInVC", bundle: nil)
            window?.rootViewController = signInVC
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
