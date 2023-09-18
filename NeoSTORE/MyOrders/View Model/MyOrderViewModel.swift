import UIKit

//MARK: - MyOrderViewModelDelegate Protocol
protocol MyOrderViewModelDelegate:NSObject{
    func successOrderList()
    func failureOrderList(msg: String)
}

//MARK: - MyOrderViewModel
class MyOrderViewModel: NSObject {
    
    //MARK: - MyOrderViewModelDelegate Object Declare
    weak var myOrderViewModelDelegate: MyOrderViewModelDelegate?
    
    //APIService Object
    private let myOrdersAPIService = MyOrdersAPIService()
    
    var orderList: MyOrderList?
    
    //API call
    func placeOrder(){
        myOrdersAPIService.getOrderList{
            response in
            switch response{
            case .success(let value):
                self.orderList = value
                self.myOrderViewModelDelegate?.successOrderList()
            case .failure(let error):
                self.myOrderViewModelDelegate?.failureOrderList(msg: error.localizedDescription)
            }
        }
    }
}
