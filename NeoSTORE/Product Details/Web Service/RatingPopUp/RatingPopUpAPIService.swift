//
//  RatingPopUpAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 31/08/23.
//

import UIKit

class RatingPopUpAPIService: NSObject {
    func postRating(productId: Int,rating: Int,completion: @escaping(Result<(ProductRating?,ProductRatingFailure?),Error>) -> Void){
        
        let param = ["product_id":productId,"rating": rating]
        APIManager.shared.callRequest(apiCallType: .setRatings(param: param)){
            (response) in
            switch response{
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(ProductRating.self, from: value)
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
