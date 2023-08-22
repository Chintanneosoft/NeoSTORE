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
    weak var loginViewModelDelegate: LoginViewModelDelegate?
    func callValidations(email:String, pass:String){
        
        validation.validationDelegate = self
        
        let validity = validation.loginValidation( email: email, password: pass)
        if validity{
            print(email,pass)
        }
    }
}
extension LoginViewModel:ValidationDelegate{
    func resultMsg(msg: String) {
        loginViewModelDelegate?.showAlert(msg: msg)
    }
}
