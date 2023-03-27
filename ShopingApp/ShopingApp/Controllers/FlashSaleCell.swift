//
//  FlashSaleCell.swift
//  ShopingApp
//
//  Created by Abduraxmon on 23/03/23.
//

import UIKit

class FlashSaleCell: UICollectionViewCell {
    
    var sum = 0
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var discountLbl: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        ProductData.products.append(Product(name:nameLbl.text ?? "", price: priceLbl.text ?? "", photo: productImage.image))
        let normal = self.addBtn.backgroundColor
        UIView.animate(withDuration: 1) {
            self.addBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.addBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.addBtn.backgroundColor = .systemGreen
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.addBtn.backgroundColor = normal
            self.addBtn.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
        sum += 1
        if sum % 2 != 0 {
            likeBtn.backgroundColor = .clear
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            UIView.animate(withDuration: 1) {
                self.likeBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        } else {
            likeBtn.backgroundColor = .systemGray5
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            UIView.animate(withDuration: 1) {
                self.likeBtn.transform = CGAffineTransform.identity
            }
        }
    }
}
