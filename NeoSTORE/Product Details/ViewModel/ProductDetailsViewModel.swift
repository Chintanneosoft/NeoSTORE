import UIKit

//MARK: - ProductDetailsViewModel Protocol
protocol ProductDetailsViewModelDelegate: NSObject{
    func setProductDetails()
    func failureProductDetails(msg: String)
}

//MARK: - ProductDetailsViewModel
class ProductDetailsViewModel: NSObject {

    //MARK: - ProductDetailsViewModelDelegate Object Declare
    weak var productDetailsViewModelDelegate : ProductDetailsViewModelDelegate?
    
    //APIService Object
    private let productDetailsAPIService = ProductDetailsAPIService()
    
    var productsDetails: ProductDetails?
    
    //API call
    func callProductDetails(productId: Int){
        productDetailsAPIService.fetchProductsDetails(productId: productId){
             (response) in
            switch response{
            case .success(let value):
                self.productsDetails = value
                self.productDetailsViewModelDelegate?.setProductDetails()
            case .failure(let error):
                self.productDetailsViewModelDelegate?.failureProductDetails(msg: error.localizedDescription)
            }
        }
    }
}
