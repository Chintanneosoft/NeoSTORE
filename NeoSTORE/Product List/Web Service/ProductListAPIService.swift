//
//  ProductListAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

import Foundation
import UIKit

class ProductListAPIService: NSObject {
    func fetchProductsList(productCategoryId: Int,completion: @escaping(Result<Products,Error>) -> Void){
        
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
    
    func fetchImages(url: URL,completion: @escaping((Result<UIImage,Error>) -> Void)){
        URLSession.shared.dataTask(with:url ) { data, response, error in
            if error != nil{
                completion(.failure(error!))
            }
            guard let image = UIImage(data: data!) else {
                    print("Invalid image data")
                    return
                }
            completion(.success(image))
            
        }.resume()
    }
}
