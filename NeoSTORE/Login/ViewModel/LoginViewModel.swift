//
//  LoginViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit

//MARK: - LoginViewModelDelegate Protocol
protocol LoginViewModelDelegate:AnyObject{
    func showAlert(msg:String)
}

//MARK: - LoginViewModel
class LoginViewModel{
    
    //MARK: - Properties
    private let validation = Validation()
    private let loginAPIService = LoginAPIService()
    
    //MARK: - LoginViewModelDelegate Object Declare
    weak var loginViewModelDelegate: LoginViewModelDelegate?
    
    //MARK: - Functions
    func callValidations(email:String, pass:String) {
        
        let validationResult = validation.loginValidation( email: email, password: pass)
        
        if validationResult.0{
            
            print(email,pass)
            loginAPIService.loginUser(email: email, pass: pass){ (response) in
                
                switch response{
                case .success(let value):
                    print(value)
                    if (value.0 != nil){
                        UserDefaults.standard.set(value.0!.data?.access_token ?? "", forKey: "accessToken")
                        self.loginViewModelDelegate?.showAlert(msg: "LoggedIn Successfully")
                    }
                    else{
                        self.loginViewModelDelegate?.showAlert(msg: value.1!.user_msg!)
                    }
                case .failure(let error):
                    print(error)
                    self.loginViewModelDelegate?.showAlert(msg: error.localizedDescription)
                }
                
            }
        }
        else{
            self.loginViewModelDelegate?.showAlert(msg: validationResult.1)
        }
    }
}
