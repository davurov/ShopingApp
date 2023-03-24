//
//  FlashSaleModel.swift
//  ShopingApp
//
//  Created by Abduraxmon on 24/03/23.
//

import Foundation

// MARK: - FlashSaleModel
struct FlashSaleModel: Codable {
    let flashSale: [FlashSale]

    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

// MARK: - FlashSale
struct FlashSale: Codable {
    let category, name: String
    let price: Double
    let discount: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageURL = "image_url"
    }
}
