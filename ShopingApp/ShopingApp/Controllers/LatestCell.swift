//
//  LatestCell.swift
//  ShopingApp
//
//  Created by Abduraxmon on 23/03/23.
//

import UIKit

class LatestCell: UICollectionViewCell {

    
    
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
}
