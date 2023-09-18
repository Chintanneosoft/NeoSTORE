import UIKit
import Foundation

// MARK: - MyOrderList
struct MyOrderList: Codable {
    let status: Int
    let data: [MyOrderListData]
    let message, userMsg: String

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

// MARK: - MyOrderListData
struct MyOrderListData: Codable {
    let id, cost: Int
    let created: String
}
