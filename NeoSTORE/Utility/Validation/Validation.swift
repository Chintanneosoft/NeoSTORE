////
////  Validation.swift
////  NeoSTORE
////
////  Created by Neosoft1 on 21/08/23.
////
//
//import Foundation
//import UIKit
//class Validation{
//
//    func alertmsg(msg:String){
//
//        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default) { (action) in
//            self.dismiss(animated: true, completion: nil)
//        }
//
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//
//    }
//
//    func validations() -> Bool{
//        let validity = nameValidation(name: tfFirstName.text) || nameValidation(name: tfLastName.text) || emailValidation(email: tfEmail.text) || passwordValidation(password: tfPassword.text) || confirmPasswordValidation(cfPassword: tfConfirmPassword.text) || (btnMale.isSelected || btnFemale.isSelected)
//        return true
//    }
//
//    private func minCountValidation(cnt: Int,expCnt: Int) -> Bool{
//        if cnt < expCnt{
//            alertmsg(msg: "Minimum expected \(expCnt)")
//            return false
//        }
//        return true
//    }
//
//    private func nameValidation(name: String) -> Bool{
//        let validity = minCountValidation(cnt: name.count, expCnt: 3)
//        return validity
//    }
//
//    private func emailValidation(email: String)-> Bool{
//
//        var validity = minCountValidation(cnt: email.count, expCnt: 3)
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        if !emailPredicate.evaluate(with: email) {
//            alertmsg(msg: "Not Followed Standard Email Requirements")
//        }
//        else{
//            return false
//        }
//        return validity
//    }
//
//    private func passwordValidation(password: String) -> Bool{
//
//        var validity = minCountValidation(cnt: password.count, expCnt: 8)
//
//        var containsNumber = false
//        for character in password {
//            if character.isWholeNumber {
//                containsNumber = true
//                break
//            }
//        }
//        if !containsNumber {
//            alertmsg(msg: "Password Should Contain atleast one Number")
//        }
//        else{
//            return false
//        }
//
//        var containsSpecialCharacter = false
//        let specialCharacters = ["@", "#", "%", "*", "(", ")", "<", ">", "/", "|", "{", "~", "?"]
//        for character in password {
//            if specialCharacters.contains(String(character)) {
//                containsSpecialCharacter = true
//                break
//            }
//        }
//        if !containsSpecialCharacter {
//            alertmsg(msg: "Password Should Contain atleast one Special Charactor")
//            return false
//        }
//        return true
//    }
//
//    private func confirmPasswordValidation(cfPassword: String){
//        if tfPassword.text != cfPassword{
//            alertmsg(msg: "Confirm Password Should be same as Password")
//        }
//    }
//}
