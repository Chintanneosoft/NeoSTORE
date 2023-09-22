import UIKit

//MARK: - CartViewModelDelegate Protocol
protocol CartViewModelDelegate:NSObject{
    func setCart()
    func failureCart(msg: String)
}

//MARK: - CartViewModel
class CartViewModel: NSObject {
    
    //MARK: - CartViewModelDelegate Object Declare
    weak var cartViewModelDelegate: CartViewModelDelegate?
    
    //APIService Object
    private let cartAPIService = CartAPIService()
    
    //properties
    var myCart : Cart?
    var cartList: [CartData]?
    var quantityArr:[String] {
        var arr:[String] = []
        for i in 1...8{
            arr += [String(i)]
        }
        return arr
    }
    
    //MARK: - Functions
    
    //API Calls
    func callFetchCart(){
        cartAPIService.getCartDetails{
             response in
            switch response{
            case .success(let value):
                if (value.0 != nil){
                    self.myCart = value.0
                    self.cartList = self.myCart?.data
                    self.cartViewModelDelegate?.setCart()
                }
                else{
                    self.cartViewModelDelegate?.failureCart(msg: value.1!.user_msg!)
                }
            case .failure(let error):
                self.cartViewModelDelegate?.failureCart(msg: error.localizedDescription)
            }
        }
    }
    
    func callUpdateCart(productId:Int,quantity:Int){
        cartAPIService.updateCart(productId:productId,quantity:quantity){
             response in
            switch response{
            case .success(let value):
                if value.data {
                    self.callFetchCart()
                }
                else{
                    self.cartViewModelDelegate?.failureCart(msg: value.user_msg)
                }
            case .failure(let error):
                self.cartViewModelDelegate?.failureCart(msg: error.localizedDescription)
            }
        }
    }
    
    func callDeleteCart(productId: Int){
        cartAPIService.deleteCart(productId: productId){
             response in
            switch response{
            case .success(let value):
                if value.data {
                    self.callFetchCart()
                }
                else{
                    self.cartViewModelDelegate?.failureCart(msg: value.user_msg)
                }
            case .failure(let error):
                self.cartViewModelDelegate?.failureCart(msg: error.localizedDescription)
            }
        }
    }
}

