//
//  ProfileAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 08/09/23.
//

import UIKit

class ProfileAPIService: NSObject {
    func updateUser(fname: String, lname: String, email: String, dob:String,profilePic:String,phone:String,completion: @escaping(Result<(User?,UserFailure?),Error>)-> Void){
        
        let param = ["first_name": fname, "last_name": lname, "email": email, "dob": dob, "profile_pic": profilePic, "phone_no": phone]
        
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
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
}
