import UIKit

//MARK: - ProfileViewModelDelegate Protocol
protocol ProfileViewModelDelegate:NSObject{
    func setUserData()
    func failureUser(msg: String)
}

//MARK: - ProfileViewModel
class ProfileViewModel: NSObject {
    
    //MARK: - ProfileViewModelDelegate Object Declare
    weak var profileViewModelDelegate: ProfileViewModelDelegate?
    
    //APIService Object
    private let profileAPIService = ProfileAPIService()
    
    let validation = Validation()
    var userData : User?
    var txtFieldData = [["First Name",ImageNames.user.rawValue],["Last Name",ImageNames.user.rawValue],["Email",ImageNames.email.rawValue],["Phone Number",ImageNames.phoneNo.rawValue],["DOB",ImageNames.dob.rawValue]]
    
    //API call
    func callUpdateUser(fname: String, lname: String, email: String, dob:String,profilePic:String,phone:String){
        profileAPIService.updateUser(fname: fname, lname: lname, email: email, dob:dob,profilePic:profilePic,phone:phone){
            response in
            switch response{
            case .success(let value):
                if (value.0 != nil){
                    self.userData = value.0
                    self.profileViewModelDelegate?.setUserData()
                }
                else{
                    self.profileViewModelDelegate?.failureUser(msg: value.1!.user_msg!)
                }
            case .failure(let error):
                self.profileViewModelDelegate?.failureUser(msg: error.localizedDescription)
            }
        }
    }
    
    func callValidations(fname: String, lname: String, email: String, dob:String,profilePic:String,phone:String){
        let validationResult = validation.updateUserValidation(fname: fname, lname: lname, email: email, dob:dob,profilePic:profilePic,phone:phone)
        if validationResult == nil{
            callUpdateUser(fname: fname, lname: lname, email: email, dob: dob, profilePic: profilePic, phone: phone)
        }
        else{
            profileViewModelDelegate?.failureUser(msg: validationResult ?? "")
        }
    }
}

