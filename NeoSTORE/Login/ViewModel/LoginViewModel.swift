//
//  LoginViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit
protocol LoginViewModelDelegate:AnyObject{
    func showAlert(msg:String)
}
class LoginViewModel{
    
    private let validation = Validation()
    
    private let loginAPIService = LoginAPIService()
    
    weak var loginViewModelDelegate: LoginViewModelDelegate?
    
    func callValidations(email:String, pass:String) {
        
        validation.validationDelegate = self
        
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
extension LoginViewModel:ValidationDelegate{
    func resultMsg(msg: String) {
        loginViewModelDelegate?.showAlert(msg: msg)
    }
}
