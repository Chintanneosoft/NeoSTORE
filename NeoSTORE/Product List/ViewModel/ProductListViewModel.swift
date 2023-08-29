//
//  ProductListViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

import UIKit

//MARK: - ProductListViewModelDelegate Protocol
protocol ProductListViewModelDelegate:NSObject{
    func setProductsList(productList: Products)
    func failureProductList(msg: String)
    func setImage(img: UIImage)
}

//MARK: - ProductListViewModel
class ProductListViewModel:NSObject {
    
    //MARK: - ProductListViewModelDelegate Object Declare
    weak var productListViewModelDelegate: ProductListViewModelDelegate?
    
    //APIService Object
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
                self.productListViewModelDelegate?.failureProductList(msg: error.localizedDescription)
            }
        }
    }
}
