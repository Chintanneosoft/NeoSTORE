import UIKit
import Foundation


// MARK: - Cart
struct Cart: Codable {
    let status: Int
    let data: [CartData]
    let count, total: Int
}

// MARK: - CartData
struct CartData: Codable {
    let id, productID, quantity: Int
    let product: CartProduct

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case quantity, product
    }
}

// MARK: - CartProduct
struct CartProduct: Codable {
    let id: Int
    let name: String
    let cost: Int
    let productCategory: String
    let productImages: String
    let subTotal: Int

    enum CodingKeys: String, CodingKey {
        case id, name, cost
        case productCategory = "product_category"
        case productImages = "product_images"
        case subTotal = "sub_total"
    }
}

//MARK: - CartUpdate
struct CartUpdate: Codable {
    let status: Int
    let data: Bool
    let total_carts: Int?
    let message,user_msg : String
}
