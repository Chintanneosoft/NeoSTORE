//
//  RegisterModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit

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
    var country_id : String?
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
        case country_id = "country_id"
        case created = "created"
        case modified = "modified"
        case access_token = "access_token"
        case dob = "dob"
        case profile_pic = "profile_pic"
    }
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        role_id = try values.decodeIfPresent(Int.self, forKey: .role_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        phone_no = try values.decodeIfPresent(String.self, forKey: .phone_no)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        is_active = try values.decodeIfPresent(Bool.self, forKey: .is_active)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
    }
}
