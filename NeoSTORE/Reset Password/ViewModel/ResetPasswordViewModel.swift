import UIKit

//MARK: - ResetPasswordViewModelDelegate Protocol
protocol ResetPasswordViewModelDelegate:AnyObject{
    func showAlert(msg:String)
}

//MARK: - ResetPasswordViewModel
class ResetPasswordViewModel{
    
    //MARK: - Properties
    private let validation = Validation()
    private let resetAPIService = ResetPasswordAPIService()
    
    //MARK: - LoginViewModelDelegate Object Declare
    weak var resetPasswordViewModelDelegate: ResetPasswordViewModelDelegate?
    
    var txtFieldData = [["Current Password","password_icon"],["New Password","password_icon"],["Confirm Password","password_icon"]]
    //MARK: - Functions
    func callValidations(oldPass: String, newPass: String, confirmPass: String ) {
        let validationResult = validation.resetPassValidation(oldPass: oldPass, newPass: newPass, confirmPass: confirmPass)
        if validationResult == nil{
            resetAPIService.resetPass(oldPass: oldPass, newPass: newPass, confirmPass: confirmPass){ [weak self] (response) in
                switch response{
                case .success(let value):
                    self?.resetPasswordViewModelDelegate?.showAlert(msg: value.user_msg!)
                case .failure(let error):
                    print(error)
                    self?.resetPasswordViewModelDelegate?.showAlert(msg: error.localizedDescription)
                }
            }
        }
        else{
            self.resetPasswordViewModelDelegate?.showAlert(msg: validationResult ?? "")
        }
    }
}
