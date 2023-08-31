//
//  EnterQuantityViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 31/08/23.
//

import UIKit

//MARK: - EnterQuantityViewModelDelegate Protocol
protocol EnterQuantityViewModelDelegate: NSObject{
    func ratingResult(title: String,msg: String)
}

//MARK: - EnterQuantityViewModel
class EnterQuantityViewModel: NSObject {
    
    //MARK: - EnterQuantityViewModelDelegate Object Declare
    weak var enterQuantityViewModelDelegate : EnterQuantityViewModelDelegate?
    
    private let enterQuantityViewAPIService = EnterQuantityViewAPIService()
    
    func callAddToCart(productId: Int,quantity: Int){
        enterQuantityViewAPIService.addToCart(productId: productId,quantity: quantity){
            (response) in
            switch response{
            case .success(let value):
                if (value.0 != nil) {
                    self.enterQuantityViewModelDelegate?.ratingResult(title: "Success",msg: value.0?.userMsg ?? "")
                }
                else{
                    self.enterQuantityViewModelDelegate?.ratingResult(title: "Error",msg: value.1?.userMsg ?? "")
                }
            case .failure(let error):
                self.enterQuantityViewModelDelegate?.ratingResult(title: "Error",msg: error.localizedDescription)
            }
        }
    }
    
}
