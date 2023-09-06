//
//  AddressListViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 05/09/23.
//

import UIKit

//MARK: - AddressListViewModelDelegate Protocol
protocol AddressListViewModelDelegate:NSObject{
    func successAddress(msg: String)
    func failureAddress(msg: String)
}

//MARK: - AddressListViewModel
class AddressListViewModel: NSObject {
    
    //MARK: - AddressListViewModelDelegate Object Declare
    weak var addressListViewModelDelegate: AddressListViewModelDelegate?
    
    //APIService Object
    private let addressListAPIService = AddressListAPIService()
    
    func placeOrder(address: String){
        addressListAPIService.placeOrder(addess: address){
            response in
            switch response{
            case .success(let value):
                print(value)
                
                self.addressListViewModelDelegate?.successAddress(msg: value.userMsg)
                
            case .failure(let error):
                print(error)
                self.addressListViewModelDelegate?.failureAddress(msg: error.localizedDescription)
            }
        }
    }
    
}
