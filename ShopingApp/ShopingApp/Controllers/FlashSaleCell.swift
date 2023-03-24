//
//  FlashSaleCell.swift
//  ShopingApp
//
//  Created by Abduraxmon on 23/03/23.
//

import UIKit

class FlashSaleCell: UICollectionViewCell {

    @IBOutlet weak var discountLbl: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}