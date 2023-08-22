//
//  RegisterViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit
protocol RegisterViewModelDelegate:AnyObject{
    func showAlert(msg:String)
}
class RegisterViewModel: RegisterAPIServiceDelegate {
  
    private let registerAPIService = RegisterAPIService()
    private let validation = Validation()
    
    weak var registerViewModelDelegate: RegisterViewModelDelegate?
    
//    init(){
//        validation.validationDelegate = self
//        registerAPIService.APIServiceDelegate = self
//    }
    
    func callValidations( fname:String, lname:String, email:String, pass:String, cpass:String, phone:String, btnSelected:String, termsAndCondition:Bool ){
        
            validation.validationDelegate = self
            registerAPIService.APIServiceDelegate = self
        
        if btnSelected == "" {
            resultMsg(msg: "Select Gender")
        }
        
        if !termsAndCondition{
            resultMsg(msg: "Agree with terms and conditions")
        }
        
        let validity = validation.registerValidation(firstName: fname, lastName: lname, email: email, password: pass, confirmPassword: cpass, mobileNumber: phone)
        if validity{
            print(fname,lname,email,pass,phone,btnSelected)
//            DispatchQueue.global().async {
                self.registerAPIService.registerUser(fname: fname, lname: lname, email: email, pass: pass, cpass: cpass, gender: btnSelected, phone: phone)
//            }
        }
    }
//    func didRegisteredUser() {
//        DispatchQueue.main.async {
//            self.registerViewModelDelegate?.showAlert(msg: "Registered Succesfully")
//        }
//    }
    func didRegisteredUser(userData: UserData) {
            DispatchQueue.main.async {
                self.registerViewModelDelegate?.showAlert(msg: "Registered Successfully")
                // Handle the registered user data here
                print("User ID: \(userData.id)")
                print("First Name: \(userData.first_name)")
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
extension RegisterViewModel: ValidationDelegate{
    func resultMsg(msg: String) {
        registerViewModelDelegate?.showAlert(msg: msg)
    }
}
