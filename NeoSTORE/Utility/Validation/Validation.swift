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

    func registerValidation(firstName: String?, lastName: String?, email: String?, password: String?, confirmPassword: String?, mobileNumber: String?) -> Bool{
        
        guard firstName != "" && lastName != "" && password != "" && confirmPassword != "" else {
            validationDelegate?.resultMsg(msg: "Please fill the required fields")
            return false
        }
        
        guard firstName!.count > 3 && containsOnlyCharacters(firstName!) == true else {
            validationDelegate?.resultMsg(msg: "Enter your valid first name")
            return false
        }
        
        guard lastName!.count > 3 && containsOnlyCharacters(lastName!) == true else {
            validationDelegate?.resultMsg( msg:"Enter your valid last name")
            return false
        }
        
        if email != "" {
            guard validateEmail(email ?? "") == true else {
                validationDelegate?.resultMsg( msg:"Enter your valid email id")
                return false
            }
        }
        
        guard password!.count >= 2 && containsOnlyAllowedCharacters(password!) == true && containsOneNumberAndOneSpecialChar(password!) == true && password! == confirmPassword! else {
            validationDelegate?.resultMsg(msg: "Enter your valid password")
            return false
        }
        
        if mobileNumber != "" {
            guard mobileNumber!.count == 10 && containsOnlyNumbers(mobileNumber!) == true else {
                validationDelegate?.resultMsg(msg:"Enter your valid mobile number")
                return false
            }
        }
        
        
        validationDelegate?.resultMsg(msg: "Validation successfull")
        return true
    }
    func loginValidation(email: String?, password: String?) -> Bool{
        
        guard email != "" && password != "" else {
            validationDelegate?.resultMsg(msg: "Please fill the required fields")
            return false
        }
        
        if email != "" {
            guard validateEmail(email ?? "") == true else {
                validationDelegate?.resultMsg( msg:"Enter your valid email id")
                return false
            }
        }
        
        guard password!.count >= 2 && containsOnlyAllowedCharacters(password!) == true && containsOneNumberAndOneSpecialChar(password!) == true else {
            validationDelegate?.resultMsg(msg: "Enter your valid password")
            return false
        }
        
        validationDelegate?.resultMsg(msg: "Validation successfull")
        return true
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
    
//    func validateInput(_ input: String) -> Bool {
//        let pattern = "^[a-zA-Z0-9]+$"
//        let regex = try! NSRegularExpression(pattern: pattern)
//        let range = NSRange(location: 0, length: input.utf16.count)
//        let matches = regex.matches(in: input, range: range)
//        return matches.count > 0
//    }
    func validateEmail(_ input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input) // Use 'input' instead of 'self'
    }
}
