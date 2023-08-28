//
//  ProductDetailsModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 28/08/23.
//

import UIKit
import Foundation

// MARK: - ProductDetails
struct ProductDetails: Codable {
    let status: Int?
    let data: ProductDetail?
    let message, userMsg: String?

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

// MARK: - DataClass
struct ProductDetail: Codable {
    let id, productCategoryID: Int?
    let name, producer, dataDescription: String?
    let cost, rating, viewCount: Int?
    let created, modified: String?
    let productImages: [ProductImage]?

    enum CodingKeys: String, CodingKey {
        case id
        case productCategoryID = "product_category_id"
        case name, producer
        case dataDescription = "description"
        case cost, rating
        case viewCount = "view_count"
        case created, modified
        case productImages = "product_images"
    }
}

// MARK: - ProductImage
struct ProductImage: Codable {
    let id, productID: Int?
    let image: String?
    let created, modified: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case image, created, modified
    }
}

