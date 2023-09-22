import UIKit

//MARK: - ResetPasswordAPIService
class ResetPasswordAPIService: NSObject {
    
    //APIRequest Function Call
    func resetPass(oldPass: String, newPass: String, confirmPass:String ,completion: @escaping(Result<UserFailure,Error>) -> Void){
        let params = [APIServiceText.oldPassword.rawValue: oldPass, APIServiceText.password.rawValue: newPass,APIServiceText.confirmPassword.rawValue: confirmPass]
        APIManager.shared.callRequest(apiCallType: .updatePass(param: params)){ (response) in
            switch response {
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(UserFailure.self, from: value)
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
