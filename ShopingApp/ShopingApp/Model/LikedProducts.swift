//
//  LikedProducts.swift
//  ShopingApp
//
//  Created by Abduraxmon on 28/03/23.
//

import Foundation
import UIKit

struct LikedProductData {
    static var products = [LikedProduct]()
}

struct LikedProduct {
    var name = ""
    var price = ""
    var photo: UIImage?
}
