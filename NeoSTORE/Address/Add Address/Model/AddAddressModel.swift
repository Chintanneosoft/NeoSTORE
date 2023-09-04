//
//  AddAddressModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 04/09/23.
//

import UIKit

class AddAddressModel: NSObject {

}
//MARK: - Order
struct Order: Codable {
    let status: Int
    let data: [OrderData]?
    let message,user_msg : String
}

// MARK: - OrderData
struct OrderData: Codable {
    let id: Int
    let cost: Double
    let created: String
}
