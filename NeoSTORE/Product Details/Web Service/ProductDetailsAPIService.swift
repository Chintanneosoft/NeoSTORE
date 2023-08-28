//
//  ProductDetailsAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 26/08/23.
//

import UIKit

class ProductDetailsAPIService: NSObject {
        func fetchProductsDetails(productId: Int,completion: @escaping(Result<ProductDetails,Error>) -> Void){
            
            let params = ["product_id" : productId]
            
            APIManager.shared.callRequest(apiCallType: .fetchProductsDetails(param: params)){ (response) in
                
                switch response {
                
                case .success(let value):
                    do {
                        let responseData = try JSONDecoder().decode(ProductDetails.self, from: value)
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
