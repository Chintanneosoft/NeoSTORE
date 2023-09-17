import Foundation

// MARK: - Products
struct Products: Codable {
    let status: Int?
    let data: [ProductsData]?
    let message, userMsg: String?

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct ProductsData: Codable {
    let id, productCategoryID: Int?
    let name, producer, datumDescription: String?
    let rating, viewCount: Int?
    let created, modified: String?
    let productImages: String?
    let cost: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productCategoryID = "product_category_id"
        case name, producer
        case datumDescription = "description"
        case cost, rating
        case viewCount = "view_count"
        case created, modified
        case productImages = "product_images"
    }
}

