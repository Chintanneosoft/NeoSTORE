//
//  DrawerAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 01/09/23.
//

import UIKit

class DrawerAPIService: NSObject {
    func fetchUser(completion: @escaping(Result<(FetchUser?,UserFailure?),Error>) -> Void){
        
        APIManager.shared.callRequest(apiCallType: .fetchUser){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(FetchUser.self, from: value)
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
