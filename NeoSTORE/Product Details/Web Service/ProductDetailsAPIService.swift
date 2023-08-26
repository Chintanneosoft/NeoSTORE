//
//  ProductDetailsAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 26/08/23.
//

import UIKit

class ProductDetailsAPIService: NSObject {
        func fetchProductsDetails(productCategoryId: Int,completion: @escaping(Result<Products,Error>) -> Void){
            
            let params = ["product_category_id" : productCategoryId]
            
            APIManager.shared.callRequest(apiCallType: .fetchProductsList(param: params)){ (response) in
                
                switch response {
                
                case .success(let value):
                    do {
                        let responseData = try JSONDecoder().decode(Products.self, from: value)
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
