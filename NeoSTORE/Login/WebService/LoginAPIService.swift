//
//  LoginAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 23/08/23.
//

import UIKit

class LoginAPIService: NSObject {
    func loginUser(email: String, pass: String, completion: @escaping(Result<(User?,UserFailure?),Error>) -> Void){
        
        let params = ["email": email, "password": pass]
        
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
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
}
