import UIKit

//MARK: - ResetPasswordViewController
class ResetPasswordViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btnResetPassword: UIButton!
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    
    //MARK: - Functions
    private func setDelegates(){
        tfNewPassword.delegate = self
        tfConfirmPassword.delegate = self
        tfCurrentPassword.delegate = self
    }
    
    private func setUpNavBar(){
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        navigationItem.title = "Reset Password"
    }
    
    private func setUpUI(){

        lblHeader.font = UIFont(name: Font.fontBold.rawValue, size: 45)
        
        tfCurrentPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfCurrentPassword.textColor = UIColor(named: "Primary Foreground")
        tfCurrentPassword.attributedPlaceholder = NSAttributedString(string: "Current Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfCurrentPassword.becomeFirstResponder()
        
        tfNewPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfNewPassword.textColor = UIColor(named: "Primary Foreground")
        tfNewPassword.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        tfConfirmPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfConfirmPassword.textColor = UIColor(named: "Primary Foreground")
        tfConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        for v in containerViews{
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
            v.layer.borderWidth = 1
        }
        
        btnResetPassword.titleLabel?.font =  UIFont(name: Font.fontRegular.rawValue, size: 18)
        btnResetPassword.layer.cornerRadius = 5.0
        
        setTapGestures()
    }
    
    //MARK: - IBActions
    
    @IBAction func btnResetPasswordTapped(_ sender: UIButton) {
        showLoader()
        let resetPasswordViewModel = ResetPasswordViewModel()
        resetPasswordViewModel.resetPasswordViewModelDelegate = self
        resetPasswordViewModel.callValidations(oldPass: tfCurrentPassword.text ?? "", newPass: tfNewPassword.text ?? "", confirmPass: tfConfirmPassword.text ?? "")
    }
}

//MARK: - TextField Delegates
extension ResetPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case tfCurrentPassword:
            textField.resignFirstResponder()
            tfNewPassword.becomeFirstResponder()
        case tfNewPassword:
            textField.resignFirstResponder()
            tfConfirmPassword.becomeFirstResponder()
        case tfConfirmPassword:
            textField.resignFirstResponder()
        default:
            return false
        }
        return true
    }
}

//MARK: - ResetPasswordViewModelDelegate
extension ResetPasswordViewController: ResetPasswordViewModelDelegate{
    
    func showAlert(msg:String) {
        DispatchQueue.main.async {
            self.hideLoader()
            if msg == "Password updated successfully"{
                self.showSingleButtonAlert(title: "Alert", msg: msg) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.showSingleButtonAlert(title: "Alert", msg: msg, okClosure: nil)
            }
        }
    }
}


