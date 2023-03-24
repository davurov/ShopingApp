//
//  SignInVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 19/03/23.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var logInLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(logInLblPressed))
        logInLbl.isUserInteractionEnabled = true
        logInLbl.addGestureRecognizer(tap)
        
    }
    
    @objc func logInLblPressed() {
        let logInVC = LogInVC(nibName: "LogInVC", bundle: nil)
        logInVC.modalPresentationStyle = .overFullScreen
        present(logInVC, animated: true)
    }
    
    @IBAction func signInPressd(_ sender: Any) {
        
        let password = "123456"
        
        if firstNameTf.text != "" && lastNameTf.text != "" {
            
            if let email = emailTf.text {
                Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
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
                        UserDefaults.standard.set(firstNameTf.text, forKey: "name")
                        UserDefaults.standard.set(emailTf.text, forKey: "email")
                        self.present(tabBarController, animated: true)
                    } else {
                        errorLbl.text = "❗️" + error!.localizedDescription
                    }
                }
            }
        } else {
            firstNameTf.layer.borderWidth = 1
            firstNameTf.layer.borderColor = UIColor.systemPink.cgColor
            lastNameTf.layer.borderWidth = 1
            lastNameTf.layer.borderColor = UIColor.systemPink.cgColor
        }
        
    }
    
}
