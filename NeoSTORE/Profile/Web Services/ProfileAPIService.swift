import UIKit

//MARK: - ProfileAPIService
class ProfileAPIService: NSObject {
    
    //API call
    func updateUser(fname: String, lname: String, email: String, dob:String,profilePic:String,phone:String,completion: @escaping(Result<(User?,UserFailure?),Error>)-> Void){
        let param = [APIServiceText.firstName.rawValue: fname, APIServiceText.lastName.rawValue: lname, APIServiceText.email.rawValue: email, APIServiceText.dob.rawValue: dob, APIServiceText.profilePic.rawValue: profilePic, APIServiceText.phoneNo.rawValue: phone]
        APIManager.shared.callRequest(apiCallType: .updateUser(param: param)){ (response) in
            switch response {
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(User.self, from: value)
                    completion(.success((responseData,nil)))
                } catch {
                    do {
                        let responseData = try JSONDecoder().decode(UserFailure.self, from: value)
                        completion(.success((nil,responseData)))
                    }
                    catch{
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
