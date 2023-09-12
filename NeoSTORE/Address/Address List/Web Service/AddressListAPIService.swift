//
//  AddressListAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 05/09/23.
//

import UIKit
//MARK: - AddressListAPIService
class AddressListAPIService: NSObject {
    
    //MARK: - API Functions
    func placeOrder(addess: String,completion: @escaping(Result<OrderList,Error>) -> Void){
        let param = ["address":addess]
        APIManager.shared.callRequest(apiCallType: .placeOrder(param: param)){ (response) in
            
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
