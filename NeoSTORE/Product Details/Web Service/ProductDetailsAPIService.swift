import UIKit

//MARK: - ProductDetailsAPIService
class ProductDetailsAPIService: NSObject {
    
    //API call
    func fetchProductsDetails(productId: Int,completion: @escaping(Result<ProductDetails,Error>) -> Void){
        
        let params = [APIServiceText.productId.rawValue : productId]
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
                completion(.failure(error))
            }
            
        }
    }
    
}
