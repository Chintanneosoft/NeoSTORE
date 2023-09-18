import UIKit

//MARK: - RegisterViewModelDelegate Protocol
protocol RegisterViewModelDelegate:NSObject {
    func showAlert(msg:String)
}

//MARK: - RegisterViewModel
class RegisterViewModel: NSObject {
    
    //MARK: - Properties
    private let registerAPIService = RegisterAPIService()
    private let validation = Validation()
    
    //MARK: - RegisterViewModelDelegate Object Declare
    weak var registerViewModelDelegate: RegisterViewModelDelegate?
    
    //MARK: - Functions
    func callValidations( fname:String, lname:String, email:String, pass:String, cpass:String, phone:String, btnSelected:String, termsAndCondition:Bool ){
        
        if btnSelected == "" {
            registerViewModelDelegate?.showAlert(msg: "Select Gender")
        }
        
        if !termsAndCondition{
            registerViewModelDelegate?.showAlert(msg: "Agree with terms and conditions")
        }
        
        let validitionResult = validation.registerValidation(firstName: fname, lastName: lname, email: email, password: pass, confirmPassword: cpass, mobileNumber: phone)
        
        if validitionResult == nil {
            self.registerAPIService.registerUser(fname: fname, lname: lname, email: email, pass: pass, cpass: cpass, gender: btnSelected, phone: phone){
                (response) in
                switch response {
                case .success(let value):
                    if value.status == 200{
                        self.registerViewModelDelegate?.showAlert(msg: "Registered Successfully")
                    }
                    else{
                        self.registerViewModelDelegate?.showAlert(msg: value.user_msg!)
                    }
                case .failure(let error):
                    self.registerViewModelDelegate?.showAlert(msg: String(error.localizedDescription))
                }
            }
        }
        else{
            self.registerViewModelDelegate?.showAlert(msg: validitionResult ?? "")
        }
    }
}
