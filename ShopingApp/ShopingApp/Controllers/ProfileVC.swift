//
//  ProfileVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 19/03/23.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    let indicators = [0,1,3,4]
    let email = UserDefaults.standard.string(forKey: "email")
    let names = ["Trade store", "Payment method", "Balance", "Trade history", "Restore Purchase", "Help", "Log out"]
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpImagePicker()
        UserName.text = UserDefaults.standard.string(forKey: "name")
        
        if let fEmail = email {
            if let photoData = UserDefaults.standard.data(forKey: fEmail) {
                userImage.image = UIImage(data: photoData)
            }
        }
        
    }

    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
    }
    
    func setUpImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }
    
    @IBAction func userImagePressed(_ sender: Any) {
        present(imagePicker, animated: true)
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        if indicators.contains(indexPath.row) {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            if indexPath.row != 4 {
                cell.photo.image = UIImage(systemName: "creditcard")
            } else {
                cell.photo.image = UIImage(systemName: "repeat")
            }
            cell.balance.isHidden = true
        } else if indexPath.row == 2 {
            cell.balance.text = "$ 1593"
            cell.balance.isHidden = false
            cell.photo.image = UIImage(systemName: "creditcard")
        } else if indexPath.row == 5 {
            cell.balance.isHidden = true
            cell.photo.image = UIImage(systemName: "questionmark.circle")
        }
        
        cell.nameLbl.text = names[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 6 {
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
            dismiss(animated: true)
        }
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage.image = userPickedImage
            let imageData = userPickedImage.pngData()
            
            if let fEmail = email {
                UserDefaults.standard.set(imageData, forKey: fEmail)
            }
            imagePicker.dismiss(animated: true)
        }
        
    }
    
}
