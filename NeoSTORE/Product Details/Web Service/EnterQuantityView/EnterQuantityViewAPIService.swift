//
//  EnterQuantityViewAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 31/08/23.
//

import UIKit

class EnterQuantityViewAPIService: NSObject {
    func addToCart(productId: Int,quantity: Int,completion: @escaping(Result<(AddToCart?,ProductRatingFailure?),Error>) -> Void){
        
        let param = ["product_id":productId,"quantity": quantity]
        APIManager.shared.callRequest(apiCallType: .addToCart(param: param)){
            (response) in
            switch response{
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(AddToCart.self, from: value)
                    completion(.success((responseData,nil)))
                }
                catch{
                    do{
                        let responseData = try JSONDecoder().decode(ProductRatingFailure.self, from: value)
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
}
