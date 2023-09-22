import UIKit

//MARK: - RegisterViewModelDelegate Protocol
protocol RegisterViewModelDelegate:NSObject {
    func showAlert(result: Bool,msg:String)
}

//MARK: - RegisterViewModel
class RegisterViewModel: NSObject {
    
    //MARK: - Properties
    private let registerAPIService = RegisterAPIService()
    private let validation = Validation()
    
    var txtFieldData = [[ScreenText.Register.firstName.rawValue,ImageNames.user.rawValue],[ScreenText.Register.lastName.rawValue,ImageNames.user.rawValue],[ScreenText.Register.email.rawValue,ImageNames.email.rawValue],[ScreenText.Register.password.rawValue,ImageNames.password.rawValue],[ScreenText.Register.confirmPassword.rawValue,ImageNames.password.rawValue],[ScreenText.Register.phoneNo.rawValue,ImageNames.phoneNo.rawValue]]
    
    //MARK: - RegisterViewModelDelegate Object Declare
    weak var registerViewModelDelegate: RegisterViewModelDelegate?
    
    //MARK: - Functions
    func callValidations( fname:String, lname:String, email:String, pass:String, cpass:String, phone:String, btnSelected:String, termsAndCondition:Bool ){
        
        if btnSelected == "" {
            registerViewModelDelegate?.showAlert(result: false,msg: AlertText.Message.genderAlert.rawValue)
        }
        
        if !termsAndCondition{
            registerViewModelDelegate?.showAlert(result: false, msg: AlertText.Message.termsAndConditions.rawValue)
        }
        
        let validitionResult = validation.registerValidation(firstName: fname, lastName: lname, email: email, password: pass, confirmPassword: cpass, mobileNumber: phone)
        
        if validitionResult == nil {
            self.registerAPIService.registerUser(fname: fname, lname: lname, email: email, pass: pass, cpass: cpass, gender: btnSelected, phone: phone){
                 (response) in
                switch response {
                case .success(let value):
                    if value.status == 200{
                        self.registerViewModelDelegate?.showAlert(result: true, msg: value.user_msg!)
                    }
                    else{
                        self.registerViewModelDelegate?.showAlert(result: false, msg: value.user_msg!)
                    }
                case .failure(let error):
                    self.registerViewModelDelegate?.showAlert(result: false, msg: String(error.localizedDescription))
                }
            }
        }
        else{
            self.registerViewModelDelegate?.showAlert(result: false, msg: validitionResult ?? "")
        }
    }
}
