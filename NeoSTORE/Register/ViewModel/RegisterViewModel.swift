//
//  RegisterViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit

protocol RegisterViewModelDelegate:NSObject {
    func showAlert(msg:String)
}
class RegisterViewModel: NSObject {
    
    let registerAPIService = RegisterAPIService()
    let validation = Validation()
    
    weak var registerViewModelDelegate: RegisterViewModelDelegate?
    
    func callValidations( fname:String, lname:String, email:String, pass:String, cpass:String, phone:String, btnSelected:String, termsAndCondition:Bool ){
        
        validation.validationDelegate = self
        
        if btnSelected == "" {
            resultMsg(msg: "Select Gender")
        }
        
        if !termsAndCondition{
            resultMsg(msg: "Agree with terms and conditions")
        }
        
        let validitionResult = validation.registerValidation(firstName: fname, lastName: lname, email: email, password: pass, confirmPassword: cpass, mobileNumber: phone)
        if validitionResult.0{
            print(fname,lname,email,pass,phone,btnSelected)
            
            self.registerAPIService.registerUser(fname: fname, lname: lname, email: email, pass: pass, cpass: cpass, gender: btnSelected, phone: phone){
                (response) in
                switch response {
                case .success(let value):
                    print(value)
                    if value.status == 200{
                        self.registerViewModelDelegate?.showAlert(msg: "Registered Successfully")
                    }
                    else{
                        self.registerViewModelDelegate?.showAlert(msg: value.user_msg!)
                    }
                case .failure(let error):
                    self.registerViewModelDelegate?.showAlert(msg: String(error.localizedDescription))
                }
            }
        }
        else{
            self.registerViewModelDelegate?.showAlert(msg: validitionResult.1)
        }
    }
    
    
}
extension RegisterViewModel: ValidationDelegate{
    func resultMsg(msg: String) {
        registerViewModelDelegate?.showAlert(msg: msg)
    }
}

