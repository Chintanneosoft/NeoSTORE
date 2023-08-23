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
    
//    init(){
//        validation.validationDelegate = self
////        registerAPIService.APIServiceDelegate = self
//    }
    
    func callValidations( fname:String, lname:String, email:String, pass:String, cpass:String, phone:String, btnSelected:String, termsAndCondition:Bool ){
        
           validation.validationDelegate = self
//            registerAPIService.APIServiceDelegate = self
        
        if btnSelected == "" {
            resultMsg(msg: "Select Gender")
        }
        
        if !termsAndCondition{
            resultMsg(msg: "Agree with terms and conditions")
        }
        
        let validity = validation.registerValidation(firstName: fname, lastName: lname, email: email, password: pass, confirmPassword: cpass, mobileNumber: phone)
        if validity{
            print(fname,lname,email,pass,phone,btnSelected)
            
//            registerAPIService.APIServiceDelegate = self
            
//            DispatchQueue.global().async {
            self.registerAPIService.registerUser(fname: fname, lname: lname, email: email, pass: pass, cpass: cpass, gender: btnSelected, phone: phone){
                (response) in
                    switch response {
                    case .success(let value):
                        print(value)
                        DispatchQueue.main.async {
                            if value.status == 200{
                                self.registerViewModelDelegate?.showAlert(msg: "Registered Successfull")
                            }
                            else{
                                self.registerViewModelDelegate?.showAlert(msg: value.user_msg!)
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.registerViewModelDelegate?.showAlert(msg: String(error.localizedDescription))
                        }
                    }
            }
//            }
        }
    }
//    func didRegisteredUser() {
//        DispatchQueue.main.async {
//            self.registerViewModelDelegate?.showAlert(msg: "Registered Succesfully")
//        }
//    }

}
extension RegisterViewModel: ValidationDelegate{
    func resultMsg(msg: String) {
        registerViewModelDelegate?.showAlert(msg: msg)
    }
}

extension RegisterViewModel {
    func didRegisteredUser(userData: UserData) {
            DispatchQueue.main.async {
                self.registerViewModelDelegate?.showAlert(msg: "Registered Successfully")
                // Handle the registered user data here
//                print("User ID: \(userData.id)")
//                print("First Name: \(userData.first_name)")
                // ... print other properties
            }
        }
        
        func didFailToRegister(error: Error) {
            DispatchQueue.main.async {
                self.registerViewModelDelegate?.showAlert(msg: "Registration Failed")
                // Handle the failure here
                print("Registration Error: \(error)")
            }
        }
    
    
}
