import UIKit

//MARK: - ProductListViewModelDelegate Protocol
protocol ProductListViewModelDelegate:NSObject{
    func setProductsList()
    func failureProductList(msg: String)
}

//MARK: - ProductListViewModel
class ProductListViewModel:NSObject {
    
    //MARK: - ProductListViewModelDelegate Object Declare
    weak var productListViewModelDelegate: ProductListViewModelDelegate?
    
    //APIService Object
    private let productListAPIService = ProductListAPIService()
    
    var productsData : Products?
    var productsDataCopy: [ProductsData] = []
    
    //API call
    func callFetchProductList(productCategory: Int){
        productListAPIService.fetchProductsList(productCategoryId: productCategory){
            response in
            switch response{
            case .success(let value):
                print(value)
                self.productsData = value
                self.productListViewModelDelegate?.setProductsList()
            case .failure(let error):
                print(error)
                self.productListViewModelDelegate?.failureProductList(msg: error.localizedDescription)
            }
        }
    }
    
    func getTitle(categoryID: Int) -> String {
        if categoryID == 1 {
            return "Tables"
        }
        else if categoryID == 2 {
            return "Chairs"
        }
        else if categoryID == 3 {
            return "Sofas"
        }
        else {
            return "Cupboards"
        }
    }
}
