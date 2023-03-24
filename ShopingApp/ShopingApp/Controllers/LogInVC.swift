//
//  LogInVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 19/03/23.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    let button = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .systemGray
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 10)
        button.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        passwordTF.rightView = button
        passwordTF.rightViewMode = .always
    }
    
    @objc func refresh() {
        
        if passwordTF.isSecureTextEntry {
            passwordTF.isSecureTextEntry = false
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordTF.isSecureTextEntry = true
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    
    @IBAction func logIPressed(_ sender: Any) {
        
        if let email = emailTF.text, let password = passwordTF.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if error == nil {
                    let mainPageVC = MainPageVC(nibName: "MainPageVC", bundle: nil)
                    let likedProductsVC = LikedProductsVC(nibName: "LikedProductsVC", bundle: nil)
                    let savedProductsVC = SavedProductsVC(nibName: "SavedProductsVC", bundle: nil)
                    let commentVC = CommentVC(nibName: "CommentVC", bundle: nil)
                    let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
                    
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
                    tabBarController.viewControllers = [mainPageVC, likedProductsVC, savedProductsVC, commentVC, profileVC]
                    tabBarController.modalPresentationStyle = .overFullScreen
                    self!.present(tabBarController, animated: true)
                } else {
                    self!.errorLbl.text = "❗️" + error!.localizedDescription
                }
            }
        }
    }
    
    
}
