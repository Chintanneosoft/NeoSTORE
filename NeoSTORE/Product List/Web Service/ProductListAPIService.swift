import Foundation
import UIKit

//MARK: - ProductListAPIService
class ProductListAPIService: NSObject {
    
    //API Call Function
    func fetchProductsList(productCategoryId: Int,completion: @escaping(Result<Products,Error>) -> Void){
        let params = [APIServiceText.productCategoryId.rawValue : productCategoryId]
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
                completion(.failure(error))
            }
        }
    }
}
