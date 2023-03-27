//
//  Product.swift
//  ShopingApp
//
//  Created by Abduraxmon on 27/03/23.
//

import Foundation
import UIKit


struct ProductData {
    static var products = [Product]()
}

struct Product {
    var name = ""
    var price = ""
    var photo: UIImage?
}
