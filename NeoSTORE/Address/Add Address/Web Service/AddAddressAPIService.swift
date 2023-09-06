//
//  AddAddressAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 04/09/23.
//

import UIKit

class AddAddressAPIService: NSObject {
    func addAddress(addess: String,completion: @escaping(Result<OrderList,Error>) -> Void){
        let param = ["address":addess]
        APIManager.shared.callRequest(apiCallType:.placeOrder(param: param)){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(OrderList.self, from: value)
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