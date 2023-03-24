//
//  ProfileCell.swift
//  ShopingApp
//
//  Created by Abduraxmon on 24/03/23.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
