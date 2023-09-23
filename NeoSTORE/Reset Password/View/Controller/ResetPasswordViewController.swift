import UIKit

//MARK: - ResetPasswordViewController
class ResetPasswordViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btnResetPassword: UIButton!
    @IBOutlet var txtCollection: [UITextField]!
    
    let resetPasswordViewModel = ResetPasswordViewModel()
    
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
    static func loadFromNib() -> UIViewController {
        return ResetPasswordViewController(nibName: ViewControllerString.ResetPassword.rawValue, bundle: nil)
    }
    
    private func setDelegates(){
        tfNewPassword.delegate = self
        tfConfirmPassword.delegate = self
        tfCurrentPassword.delegate = self
    }
    
    private func setUpNavBar(){
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        navigationItem.title = ScreenText.ResetPassword.navTitle.rawValue
    }
    
    private func setUpUI(){

        lblHeader.font = UIFont.customFont(Font.fontBold, size: 45)
        
        for (index,txtv) in txtCollection.enumerated(){
            txtv.layer.borderWidth = 1.0
            txtv.layer.borderColor = UIColor.customColor(Color.primaryForeground).cgColor
            txtv.font = UIFont.customFont(Font.fontRegular, size: 18)
            txtv.textColor = UIColor.customColor(Color.primaryForeground)
            txtv.setPlaceholder(resetPasswordViewModel.txtFieldData[index][0])
            txtv.setIcon(UIImage(named: resetPasswordViewModel.txtFieldData[index][1])!)
        }
        
        btnResetPassword.titleLabel?.font = UIFont.customFont(Font.fontRegular, size: 18)
        btnResetPassword.layer.cornerRadius = 5.0
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
    
    func showAlert(result:Bool,msg:String) {
        DispatchQueue.main.async {
            self.hideLoader()
            if result{
                self.showSingleButtonAlert(title: AlertText.Title.success.rawValue, msg: msg) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
            }
        }
    }
}


