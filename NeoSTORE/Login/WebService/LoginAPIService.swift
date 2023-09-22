import UIKit

//MARK: - LoginAPIService
class LoginAPIService: NSObject {
    
    //APIRequest Function Call
    func loginUser(email: String, pass: String, completion: @escaping(Result<(User?,UserFailure?),Error>) -> Void){
        
        let params = [APIServiceText.email.rawValue: email,APIServiceText.password.rawValue: pass]
        
        APIManager.shared.callRequest(apiCallType: .userLogin(param: params)){ (response) in
            switch response {
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(User.self, from: value)
                    completion(.success((responseData,nil)))
                } catch {
                    do{
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
    
    func forgotPass(email: String, completion: @escaping(Result<UserFailure,Error>) -> Void){
        
        let params = [APIServiceText.email.rawValue: email]
        
        APIManager.shared.callRequest(apiCallType: .forgotPass(param: params)){ (response) in
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
