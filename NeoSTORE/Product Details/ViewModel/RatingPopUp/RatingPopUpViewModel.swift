import UIKit

//MARK: - RatingPopUpViewModelDelegate Protocol
protocol RatingPopUpViewModelDelegate: NSObject{
    func ratingResult(title: String,msg: String)
}

//MARK: - RatingPopUpViewModel
class RatingPopUpViewModel: NSObject {
    
    //MARK: - RatingPopUpViewModelDelegate Object Declare
    weak var ratingPopUpViewModelDelegate : RatingPopUpViewModelDelegate?
    
    private let ratingPopUpAPIService = RatingPopUpAPIService()
    
    //API call
    func callPostRating(productId: Int,rating: Int){
        ratingPopUpAPIService.postRating(productId: productId, rating: rating){  (response) in
            switch response{
            case .success(let value):
                if (value.0 != nil) {
                    self.ratingPopUpViewModelDelegate?.ratingResult(title: AlertText.Title.success.rawValue,msg: value.0?.userMsg ?? "")
                }
                else{
                    self.ratingPopUpViewModelDelegate?.ratingResult(title: AlertText.Title.error.rawValue,msg: value.1?.userMsg ?? "")
                }
            case .failure(let error):
                self.ratingPopUpViewModelDelegate?.ratingResult(title: AlertText.Title.error.rawValue,msg: error.localizedDescription)
            }
        }
    }
}
