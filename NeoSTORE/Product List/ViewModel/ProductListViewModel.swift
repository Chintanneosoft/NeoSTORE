//
//  ProductListViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

import UIKit
protocol ProductListViewModelDelegate:NSObject{
    func setProductsList(productList: Products)
    func failureProductList()
}
class ProductListViewModel {
    
    weak var productListViewModelDelegate: ProductListViewModelDelegate?
    private let productListAPIService = ProductListAPIService()
    
    func callFetchProductList(productCategory: Int){
        productListAPIService.fetchProductsList(productCategoryId: productCategory){
            response in
            switch response{
            case .success(let value):
                print(value)
                self.productListViewModelDelegate?.setProductsList(productList: value)
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
