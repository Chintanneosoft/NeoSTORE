import UIKit

//MARK: - EnterQuantityViewModelDelegate Protocol
protocol EnterQuantityViewModelDelegate: NSObject{
    func updateQuantity(cartCount: Int,title: String,msg: String)
}

//MARK: - EnterQuantityViewModel
class EnterQuantityViewModel: NSObject {
    
    //MARK: - EnterQuantityViewModelDelegate Object Declare
    weak var enterQuantityViewModelDelegate : EnterQuantityViewModelDelegate?
    
    private let enterQuantityViewAPIService = EnterQuantityViewAPIService()
    
    //API call
    func callAddToCart(productId: Int,quantity: Int){
        enterQuantityViewAPIService.addToCart(productId: productId,quantity: quantity){
            (response) in
            switch response{
            case .success(let value):
                if (value.0 != nil) {
                    self.enterQuantityViewModelDelegate?.updateQuantity(cartCount:value.0?.total_carts ?? 0,title: AlertText.Title.success.rawValue,msg: value.0?.userMsg ?? "")
                }
                else{
                    self.enterQuantityViewModelDelegate?.updateQuantity(cartCount: 0,title: AlertText.Title.error.rawValue,msg: value.1?.userMsg ?? "")
                }
            case .failure(let error):
                self.enterQuantityViewModelDelegate?.updateQuantity(cartCount: 0,title: AlertText.Title.error.rawValue,msg: error.localizedDescription)
            }
        }
    }
}
