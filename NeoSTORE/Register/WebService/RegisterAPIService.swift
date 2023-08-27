//
//  RegisterApiService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit

//MARK: - RegisterAPIService
class RegisterAPIService {
    
    //APIRequest Function Call
    func registerUser(fname: String, lname: String, email: String, pass: String, cpass: String, gender: String, phone: String,completion: @escaping(Result<User,Error>) -> Void){
        
        let params = ["first_name": fname, "last_name": lname, "email": email, "password": pass, "confirm_password": cpass,"gender": gender, "phone_no": phone]
        
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
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
}
