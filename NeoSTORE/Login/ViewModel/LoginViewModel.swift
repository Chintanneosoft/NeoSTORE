import UIKit

//MARK: - LoginViewModelDelegate Protocol
protocol LoginViewModelDelegate:AnyObject{
    func showAlert(msg:String)
}

//MARK: - LoginViewModel
class LoginViewModel{
    
    //MARK: - Properties
    private let validation = Validation()
    private let loginAPIService = LoginAPIService()
    
    //MARK: - LoginViewModelDelegate Object Declare
    weak var loginViewModelDelegate: LoginViewModelDelegate?
    
    var txtFieldData = [["Username","username_icon"],["Password","password_icon"]]
    
    //MARK: - Functions
    func callValidations(email:String, pass:String) {

        let validationResult = validation.loginValidation( email: email, password: pass)
        //wrong
        if validationResult == nil{
        
            loginAPIService.loginUser(email: email, pass: pass){ (response) in
                switch response{
                case .success(let value):
                    print(value)
                    if (value.0 != nil){
                        UserDefaults.standard.set(value.0!.data?.access_token ?? "", forKey: "accessToken")
                        UserDefaults.standard.set(value.0!.data?.first_name ?? "" ,forKey: "userFirstName")
                        self.loginViewModelDelegate?.showAlert(msg: "LoggedIn Successfully")
                    }
                    else{
                        self.loginViewModelDelegate?.showAlert(msg: value.1!.user_msg!)
                    }
                case .failure(let error):
                    print(error)
                    self.loginViewModelDelegate?.showAlert(msg: error.localizedDescription)
                }
            }
        } else {
            self.loginViewModelDelegate?.showAlert(msg: validationResult ?? "")
        }
    }
    
    func callForgotPass(email: String){
        loginAPIService.forgotPass(email: email){ (response) in
            switch response{
            case .success(let value):
                self.loginViewModelDelegate?.showAlert(msg: value.user_msg ?? "")
            case .failure(let error):
                print(error)
                self.loginViewModelDelegate?.showAlert(msg: error.localizedDescription)
            }
        }
    }
}
