import UIKit

//MARK: - OrderDetailsViewModelDelegate Protocol
protocol OrderDetailsViewModelDelegate:NSObject{
    func successOrderDetails()
    func failureOrderDetails(msg: String)
}

//MARK: - OrderDetailsViewModel
class OrderDetailsViewModel: NSObject {
    
    //MARK: - MyOrderViewModelDelegate Object Declare
    weak var orderDetailsViewModelDelegate: OrderDetailsViewModelDelegate?
    
    //APIService Object
    private let orderDetailsAPIService = OrderDetailsAPIService()
    
    var orderDetails: OrderDetails?
    
    //API call
    func getOrderDetails(orderId: Int){
        orderDetailsAPIService.getOrderDetails(orderId:orderId){
            response in
            switch response{
            case .success(let value):
                self.orderDetails = value
                self.orderDetailsViewModelDelegate?.successOrderDetails()
            case .failure(let error):
                self.orderDetailsViewModelDelegate?.failureOrderDetails(msg: error.localizedDescription)
            }
        }
    }
}
