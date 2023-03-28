//
//  ProductDetailVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 19/03/23.
//

import UIKit
class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var savedView: UIView!
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet var productCollors: [UIButton]!
    
    var product = Product()
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImage.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(firstImagePressed))
        firstImage.addGestureRecognizer(tap1)
        
        secondImage.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(secondImagePressed))
        secondImage.addGestureRecognizer(tap2)
        
        thirdImage.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(thirdImagePressed))
        thirdImage.addGestureRecognizer(tap3)
        
    }
    
    @objc func firstImagePressed() {
        UIView.animate(withDuration: 0.3) {
            self.firstImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.secondImage.transform = CGAffineTransform.identity
            self.thirdImage.transform = CGAffineTransform.identity
        }
    }
    
    @objc func secondImagePressed() {
        UIView.animate(withDuration: 0.3) {
            self.secondImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.firstImage.transform = CGAffineTransform.identity
            self.thirdImage.transform = CGAffineTransform.identity
        }
    }
    
    @objc func thirdImagePressed() {
        UIView.animate(withDuration: 0.3) {
            self.thirdImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.secondImage.transform = CGAffineTransform.identity
            self.firstImage.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func productColor(_ sender: UIButton) {
        
        productCollors[sender.tag].layer.borderWidth = 2
        
        
        for i in 0...2 {
            if i != sender.tag {
                productCollors[i].layer.borderColor = UIColor.white.cgColor
            } else {
                productCollors[sender.tag].layer.borderColor = UIColor.systemGray.cgColor
            }
        }
        
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        guard productName.text != nil, mainPhoto.image != nil, ProductPrice.text != nil else {
            fatalError("find nil")
        }
        
        ProductData.products.append(Product(name: productName.text!, price: ProductPrice.text!, photo: mainPhoto.image!))
        self.savedView.transform = CGAffineTransform.identity
        self.savedView.isHidden = false
        
        UIView.animate(withDuration: 1) {
            self.savedView.transform = CGAffineTransform(translationX: 0, y: -200)
        }
    }
    
    
    @IBAction func sharePressed(_ sender: Any) {
    }
    @IBAction func likePressed(_ sender: Any) {
        sum += 1
        if sum % 2 != 0 {
            LikedProductData.products.append(LikedProduct(name: productName.text ?? "", price: ProductPrice.text ?? "", photo: mainPhoto.image))
            likeBtn.backgroundColor = .clear
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            UIView.animate(withDuration: 0.8) {
                self.likeBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        } else {
            LikedProductData.products.removeLast()
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            UIView.animate(withDuration: 0.8) {
                self.likeBtn.transform = CGAffineTransform.identity
            }
        }
    }
    
}
