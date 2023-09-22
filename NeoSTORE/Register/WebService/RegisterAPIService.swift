import UIKit

//MARK: - RegisterAPIService
class RegisterAPIService {
    
    //APIRequest Function Call
    func registerUser(fname: String, lname: String, email: String, pass: String, cpass: String, gender: String, phone: String,completion: @escaping(Result<User,Error>) -> Void){
        let params = [APIServiceText.firstName.rawValue: fname, APIServiceText.lastName.rawValue: lname, APIServiceText.email.rawValue: email, APIServiceText.password.rawValue: pass, APIServiceText.confirmPassword.rawValue: cpass,APIServiceText.gender.rawValue: gender, APIServiceText.phoneNo.rawValue: phone] 
        APIManager.shared.callRequest(apiCallType: .userRegister(param: params)){ (response) in
            switch response {
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(User.self, from: value)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
