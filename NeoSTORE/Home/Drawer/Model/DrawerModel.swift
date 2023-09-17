import UIKit
import Foundation

// MARK: - FetchUser
struct FetchUser: Codable {
    var status: Int?
    var data: Profile?
    var message: String?
    var user_msg: String?
    
    enum codingKeys: String,CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

// MARK: - Profile
struct Profile : Codable {
    var user_data: UserData?
    var product_categories: [ProductCategories]?
    var total_carts: Int?
    var total_orders: Int?
    
    enum codingKeys: String,CodingKey {
        case user_data = "user_data"
        case product_categories = "product_categories"
        case total_carts = "total_carts"
        case total_orders = "total_orders"
    }
}

// MARK: - ProductCategories
struct ProductCategories : Codable {
    var id: Int?
    var name: String?
    var icon_image: String?
    var created: String?
    var modified: String?
    
    enum codingKeys: String,CodingKey {
        case id = "id"
        case name = "name"
        case icon_image = "icon_image"
        case created = "created"
        case modified = "modified"
    }
}




