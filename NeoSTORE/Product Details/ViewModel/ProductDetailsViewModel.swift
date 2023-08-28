//
//  ProductDetailsViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 26/08/23.
//

import UIKit

//MARK: - ProductDetailsViewModel Protocol
protocol ProductDetailsViewModelDelegate: NSObject{
    func setProductDetails(productDetails: ProductDetails)
    func failureProductDetails(msg: String)
}

//MARK: - ProductDetailsViewModel
class ProductDetailsViewModel: NSObject {

    //MARK: - ProductDetailsViewModelDelegate Object Declare
    weak var productDetailsViewModelDelegate : ProductDetailsViewModelDelegate?
    
    //APIService Object
    private let productDetailsAPIService = ProductDetailsAPIService()
    
    func callProductDetails(productId: Int){
        productDetailsAPIService.fetchProductsDetails(productId: productId){
            (response) in
            switch response{
            case .success(let value):
                print(value)
                self.productDetailsViewModelDelegate?.setProductDetails(productDetails: value)
            case .failure(let error):
                print(error)
                self.productDetailsViewModelDelegate?.failureProductDetails(msg: error.localizedDescription)
            }
        }
    }
}
