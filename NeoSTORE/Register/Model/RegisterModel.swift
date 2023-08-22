//
//  RegisterModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit
//
////MARK: - User
//struct User: Codable {
//    let status: Int
//    let data: UserData
//    let message, userMsg: String
//
//    enum CodingKeys: String, CodingKey {
//        case status, data, message
//        case userMsg = "user_msg"
//    }
//}
//
//// MARK: - UserData
//struct UserData: Codable {
//    let id, roleID: Int
//    let firstName, lastName, email, username: String
//    let profilePic, countryID: JSONNull?
//    let gender, phoneNo: String
//    let dob: JSONNull?
//    let isActive: Bool
//    let created, modified: Date
//    let accessToken: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case roleID = "role_id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case email, username
//        case profilePic = "profile_pic"
//        case countryID = "country_id"
//        case gender
//        case phoneNo = "phone_no"
//        case dob
//        case isActive = "is_active"
//        case created, modified
//        case accessToken = "access_token"
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

struct User: Codable {
    var status: Int?
    var data: UserData?
    var message: String?
    var user_msg: String?
    
    enum codingKeys: String,CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct UserData: Codable {
    var id: Int?
    var role_id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var username: String?
    var gender: String?
    var phone_no: String?
    var is_active: Bool?
    var created: String?
    var modified: String?
    var access_token: String?
    
    var dob: String?
    var profile_pic: String?
    
    enum codingKeys: String,CodingKey {
        case id = "id"
        case role_id = "role_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case username = "username"
        case gender = "gender"
        case phone_no = "phone_no"
        case is_active = "is_active"
        case created = "created"
        case modified = "modified"
        case access_token = "access_token"
        case dob = "dob"
        case profile_pic = "profile_pic"
    }
}
