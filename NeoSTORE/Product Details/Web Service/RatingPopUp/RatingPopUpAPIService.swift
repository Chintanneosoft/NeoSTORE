import UIKit

//MARK: - RatingPopUpAPIService
class RatingPopUpAPIService: NSObject {
    
    //API Call
    func postRating(productId: Int,rating: Int,completion: @escaping(Result<(ProductRating?,ProductRatingFailure?),Error>) -> Void){
        
        let param = [APIServiceText.productId.rawValue:productId,APIServiceText.rating.rawValue: rating]
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
