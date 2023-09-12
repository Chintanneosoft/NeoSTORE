//
//  ResetPasswordAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 11/09/23.
//

import UIKit

//MARK: - ResetPasswordAPIService
class ResetPasswordAPIService: NSObject {
    
    //APIRequest Function Call
    func resetPass(oldPass: String, newPass: String, confirmPass:String ,completion: @escaping(Result<UserFailure,Error>) -> Void){
        
        let params = ["old_password": oldPass, "password": newPass,"confirm_password": confirmPass]
        
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
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
}
