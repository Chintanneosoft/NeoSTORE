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
    func callValidations(email:String, pass:String){
        
        validation.validationDelegate = self
        
        let validity = validation.loginValidation( email: email, password: pass)
        if validity{
            print(email,pass)
            loginAPIService.loginUser(email: email, pass: pass){ (response) in
                switch response{
                case .success(let value):
                    print(value)
                    DispatchQueue.main.async {
                        if value.status == 200{
                            self.loginViewModelDelegate?.showAlert(msg: "LoggedIn Successfully")
                        }
                        else{
                            self.loginViewModelDelegate?.showAlert(msg: value.user_msg!)
                        }
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.loginViewModelDelegate?.showAlert(msg: error.localizedDescription)
                    }
                }
                
            }
        }
    }
}
extension LoginViewModel:ValidationDelegate{
    func resultMsg(msg: String) {
        loginViewModelDelegate?.showAlert(msg: msg)
    }
}
