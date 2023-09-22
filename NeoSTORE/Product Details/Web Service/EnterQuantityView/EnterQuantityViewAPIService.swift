import UIKit

//MARK: - EnterQuantityViewAPIService
class EnterQuantityViewAPIService: NSObject {
    
    //API call
    func addToCart(productId: Int,quantity: Int,completion: @escaping(Result<(AddToCart?,ProductRatingFailure?),Error>) -> Void){
        
        let param = [APIServiceText.productId.rawValue:productId,APIServiceText.quantity.rawValue: quantity]
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
