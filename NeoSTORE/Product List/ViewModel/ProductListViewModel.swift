//
//  ProductListViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

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
}
