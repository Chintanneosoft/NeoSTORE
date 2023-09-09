//
//  DrawerViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 01/09/23.
//

import UIKit

//MARK: - DrawerViewModelDelegate Protocol
protocol DrawerViewModelDelegate:NSObject{
    func setDrawer()
    func failureDrawer(msg: String)
}

//MARK: - DrawerViewModel
class DrawerViewModel:NSObject {
    
    //MARK: - ProductListViewModelDelegate Object Declare
    weak var drawerViewModelDelegate: DrawerViewModelDelegate?
    
    //APIService Object
    private let drawerAPIService = DrawerAPIService()
    
    var userData : FetchUser?
    
    func callFetchUser(){
        drawerAPIService.fetchUser{
            (response) in
            switch response{
            case .success(let value):
                print(value)
                if (value.0 != nil){
                    self.userData = value.0
                    self.drawerViewModelDelegate?.setDrawer()
                }
                else{
                    self.drawerViewModelDelegate?.failureDrawer(msg: value.1!.user_msg!)
                }
            case .failure(let error):
                print(error)
                self.drawerViewModelDelegate?.failureDrawer(msg: error.localizedDescription)
            }
        }
    }
}


