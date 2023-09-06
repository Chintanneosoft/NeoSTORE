//
//  MyOrderViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

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
    
    func getOrderDetails(orderId: Int){
        orderDetailsAPIService.getOrderDetails(orderId:orderId){
            response in
            switch response{
            case .success(let value):
                print(value)
                self.orderDetails = value
                self.orderDetailsViewModelDelegate?.successOrderDetails()
                
            case .failure(let error):
                print(error)
                self.orderDetailsViewModelDelegate?.failureOrderDetails(msg: error.localizedDescription)
            }
        }
    }
    
}
