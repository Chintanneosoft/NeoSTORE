import UIKit

//MARK: - ResetPasswordViewModelDelegate Protocol
protocol ResetPasswordViewModelDelegate:AnyObject{
    func showAlert(result:Bool,msg:String)
}

//MARK: - ResetPasswordViewModel
class ResetPasswordViewModel{
    
    //MARK: - Properties
    private let validation = Validation()
    private let resetAPIService = ResetPasswordAPIService()
    
    //MARK: - LoginViewModelDelegate Object Declare
    weak var resetPasswordViewModelDelegate: ResetPasswordViewModelDelegate?
    
    var txtFieldData = [[ScreenText.ResetPassword.currentPassword.rawValue,ImageNames.password.rawValue],[ScreenText.ResetPassword.newPassword.rawValue,ImageNames.password.rawValue],[ScreenText.ResetPassword.confirmPassword.rawValue,ImageNames.password.rawValue]]
    //MARK: - Functions
    func callValidations(oldPass: String, newPass: String, confirmPass: String ) {
        let validationResult = validation.resetPassValidation(oldPass: oldPass, newPass: newPass, confirmPass: confirmPass)
        if validationResult == nil{
            resetAPIService.resetPass(oldPass: oldPass, newPass: newPass, confirmPass: confirmPass){  (response) in
                switch response{
                case .success(let value):
                    self.resetPasswordViewModelDelegate?.showAlert(result: true, msg: value.user_msg!)
                case .failure(let error):
                    self.resetPasswordViewModelDelegate?.showAlert(result: false, msg: error.localizedDescription)
                }
            }
        }
        else{
            self.resetPasswordViewModelDelegate?.showAlert(result: false, msg: validationResult ?? "")
        }
    }
}
