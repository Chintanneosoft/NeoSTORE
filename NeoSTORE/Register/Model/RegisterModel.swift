import UIKit

//MARK: - User
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

//MARK: - UserData
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
}

//MARK: - UserFailure
struct UserFailure : Codable {
    let status : Int?
    let data : Bool?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}
