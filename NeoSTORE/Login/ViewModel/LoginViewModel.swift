import UIKit

//MARK: - LoginViewModelDelegate Protocol
protocol LoginViewModelDelegate:AnyObject{
    func showAlert(result:Bool,msg:String)
}

//MARK: - LoginViewModel
class LoginViewModel{
    
    //MARK: - Properties
    private let validation = Validation()
    private let loginAPIService = LoginAPIService()
    
    //MARK: - LoginViewModelDelegate Object Declare
    weak var loginViewModelDelegate: LoginViewModelDelegate?
    
    var txtFieldData = [[ScreenText.Login.userName.rawValue,ImageNames.user.rawValue],[ScreenText.Login.password.rawValue,ImageNames.password.rawValue]]
    
    //MARK: - Functions
    func callValidations(email:String, pass:String) {

        let validationResult = validation.loginValidation( email: email, password: pass)
        //wrong
        if validationResult == nil{
            loginAPIService.loginUser(email: email, pass: pass){
                 (response) in
                switch response{
                case .success(let value):
                    if (value.0 != nil){
                        UserDefaults.standard.set(value.0!.data?.access_token ?? "", forKey: UserDefaultsKeys.accessToken.rawValue)
                        UserDefaults.standard.set(value.0!.data?.first_name ?? "" ,forKey: UserDefaultsKeys.userFirstName.rawValue)
                        self.loginViewModelDelegate?.showAlert(result: true,msg: value.0!.user_msg!)
                    }
                    else{
                        self.loginViewModelDelegate?.showAlert(result: false, msg: value.1!.user_msg!)
                    }
                case .failure(let error):
                    print(error)
                    self.loginViewModelDelegate?.showAlert(result: false, msg: error.localizedDescription)
                }
            }
        } else {
            self.loginViewModelDelegate?.showAlert(result: false, msg: validationResult ?? "")
        }
    }
    
    func callForgotPass(email: String){
        loginAPIService.forgotPass(email: email){ (response) in
            switch response{
            case .success(let value):
                self.loginViewModelDelegate?.showAlert(result: true, msg: value.user_msg ?? "")
            case .failure(let error):
                print(error)
                self.loginViewModelDelegate?.showAlert(result: false, msg: error.localizedDescription)
            }
        }
    }
}
