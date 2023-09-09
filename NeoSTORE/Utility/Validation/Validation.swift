//
//  Validation.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import Foundation
import UIKit
protocol ValidationDelegate:AnyObject{
    func resultMsg(msg:String)
}
class Validation{
    
    weak var validationDelegate:ValidationDelegate?

    func registerValidation(firstName: String?, lastName: String?, email: String?, password: String?, confirmPassword: String?, mobileNumber: String?) -> (Bool,String){
        
        guard firstName != "" && lastName != "" && password != "" && confirmPassword != "" && email != "" && mobileNumber != "" else {
//            validationDelegate?.resultMsg(msg: "Please fill the required fields")
            return (false,"Please fill the required fields")
        }
        
        guard firstName!.count > 3 && containsOnlyCharacters(firstName!) == true else {
//            validationDelegate?.resultMsg(msg: "Enter your valid first name")
            return (false,"Enter your valid first name")
        }
        
        guard lastName!.count > 3 && containsOnlyCharacters(lastName!) == true else {
//            validationDelegate?.resultMsg( msg:"Enter your valid last name")
            return (false,"Enter your valid last name")
        }
        
        if email != "" {
            guard validateEmail(email ?? "") == true else {
//                validationDelegate?.resultMsg( msg:"Enter your valid email id")
                return (false,"Enter your valid email id")
            }
        }
        
        guard password!.count >= 2 && containsOnlyAllowedCharacters(password!) == true && containsOneNumberAndOneSpecialChar(password!) == true && password! == confirmPassword! else {
//            validationDelegate?.resultMsg(msg: "Enter your valid password")
            return (false,"Enter your valid password")
        }
        
        if mobileNumber != "" {
            guard mobileNumber!.count == 10 && containsOnlyNumbers(mobileNumber!) == true else {
//                validationDelegate?.resultMsg(msg:"Enter your valid mobile number")
                return (false,"Enter your valid mobile number")
            }
        }
        
        
//        validationDelegate?.resultMsg(msg: "Validation successfull")
        return (true,msg: "Validation successfull")
    }
    
    func loginValidation(email: String?, password: String?) -> (Bool,String){
        
        guard email != "" && password != "" else {
//            validationDelegate?.resultMsg(msg: "Please fill the required fields")
            return (false,"Please fill the required fields")
        }
        
        if email != "" {
            guard validateEmail(email ?? "") == true else {
//                validationDelegate?.resultMsg( msg:"Enter your valid email id")
                return (false,"Enter your valid email id")
            }
        }
        
        guard password!.count >= 2 && containsOnlyAllowedCharacters(password!) == true && containsOneNumberAndOneSpecialChar(password!) == true else {
//            validationDelegate?.resultMsg(msg: "Enter your valid password")
            return (false,"Enter your valid password")
        }
        
//        validationDelegate?.resultMsg(msg: "Validation successfull")
        return (true,"Enter your valid password")
    }
    
    func updateUserValidation(fname: String, lname: String, email: String, dob:String,profilePic:String,phone:String) -> (Bool,String){
        guard fname != "" && lname != "" && email != "" && dob != "" && profilePic != "" && phone != "" else {
//            validationDelegate?.resultMsg(msg: "Please fill the required fields")
            return (false,"Please fill the required fields")
        }
        if email != "" {
            guard validateEmail(email ) == true else {
//                validationDelegate?.resultMsg( msg:"Enter your valid email id")
                return (false,"Enter your valid email id")
            }
        }
        return (true,"Validation SuccessFull")
    }
    func containsOnlyCharacters(_ input: String) -> Bool {
        let characterSet = CharacterSet.letters
        return input.rangeOfCharacter(from: characterSet.inverted) == nil
    }
    
    func containsOnlyAllowedCharacters(_ input: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+")
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return allowedCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func containsOneNumberAndOneSpecialChar(_ input: String) -> Bool {
        let numberRegex = ".*\\d.*"
        let specialCharRegex = ".*[^A-Za-z0-9].*"
        
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        let specialCharPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        
        let containsNumber = numberPredicate.evaluate(with: input)
        let containsSpecialChar = specialCharPredicate.evaluate(with: input)
        
        return containsNumber && containsSpecialChar
    }
    
    func containsOnlyNumbers(_ input: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return numericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func validateEmail(_ input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input) // Use 'input' instead of 'self'
    }
}
