//
//  MyOrderViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

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
    
    func placeOrder(){
        myOrdersAPIService.getOrderList{
            response in
            switch response{
            case .success(let value):
                print(value)
                self.orderList = value
                self.myOrderViewModelDelegate?.successOrderList()
                
            case .failure(let error):
                print(error)
                self.myOrderViewModelDelegate?.failureOrderList(msg: error.localizedDescription)
            }
        }
    }
    
}
