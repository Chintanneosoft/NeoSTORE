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


// MARK: - ProductRating
struct ProductRating: Codable {
    let status: Int?
    let data: ProductRatingData?
    let message, userMsg: String?

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct ProductRatingData: Codable {
    let id, productCategoryID: Int?
    let name, producer, datumDescription: String?
    let rating : Double?
        let viewCount: Int?
    let created, modified: String?
//    let productImages: String?
    let cost: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productCategoryID = "product_category_id"
        case name, producer
        case datumDescription = "description"
        case cost, rating
        case viewCount = "view_count"
        case created, modified
//        case productImages = "product_images"
    }
}


// MARK: - ProductRatingFailure
struct ProductRatingFailure:Codable{
    let status: Int?
    let data: Bool?
    let message, userMsg: String?
    enum CodingKeys: String, CodingKey{
        case status,data,message
        case userMsg = "user_msg"
    }
}

// MARK: - AddToCart
struct AddToCart:Codable{
    let status: Int?
    let data: Bool?
    let total_carts: Int?
    let message, userMsg: String?
    enum CodingKeys: String, CodingKey{
        case status,data,message,total_carts
        case userMsg = "user_msg"
    }
}
