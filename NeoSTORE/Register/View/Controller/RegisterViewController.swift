import UIKit

//MARK: - RegisterViewController
class RegisterViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblTermsAndConditions: UILabel!
    @IBOutlet var containerView: [UIView]!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var termsAndCondition: UIButton!
    @IBOutlet weak var registerScrollView: UIScrollView!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelegates()
    }
    
    //MARK: - Functions
    private func setUpUI(){
        //Navigation bar\
        self.navigationController?.navigationBar.isHidden = false
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        
        navigationItem.title = "Register"
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
        
        //Labels
        lblHeading.font = UIFont(name: Font.fontBold.rawValue, size: 45)
        lblTermsAndConditions.font = UIFont(name: Font.fontBold.rawValue, size: 13)
        
        //Views
        for v in containerView{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        
        //TextFields
        tfFirstName.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfFirstName.textColor = UIColor(named: "Primary Foreground")
        tfFirstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfLastName.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfLastName.textColor = UIColor(named: "Primary Foreground")
        tfLastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfEmail.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfEmail.textColor = UIColor(named: "Primary Foreground")
        tfEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfPassword.textColor = UIColor(named: "Primary Foreground")
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfConfirmPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfConfirmPassword.textColor = UIColor(named: "Primary Foreground")
        tfConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfPhoneNumber.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfPhoneNumber.textColor = UIColor(named: "Primary Foreground")
        tfPhoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        //Buttons
        btnRegister.titleLabel?.font =  UIFont(name: Font.fontRegular.rawValue, size: 26)
        btnRegister.layer.cornerRadius = 5.0
        
        setTapGesturesRemoveable()
        addObservers()
    }
    
    private func setDelegates(){
        tfFirstName.delegate = self
        tfLastName.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
        tfPhoneNumber.delegate = self
    }
    
    private func sendValidations(){
        let registerViewModel = RegisterViewModel()
        registerViewModel.registerViewModelDelegate = self
        registerViewModel.callValidations(fname: tfFirstName.text ?? "", lname: tfLastName.text ?? "", email: tfEmail.text ?? "", pass: tfPassword.text ?? "", cpass: tfConfirmPassword.text ?? "", phone: tfPhoneNumber.text ?? "", btnSelected:btnMale.isSelected ? "Male" : (btnFemale.isSelected ? "Female" : ""), termsAndCondition: termsAndCondition.isSelected)
    }
    
    //MARK: - @objc Functions
    @objc func leftBarButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - IBActions
    @IBAction func btnRadioTapped(_ sender: UIButton) {
        btnMale.isSelected = sender == btnMale
        btnFemale.isSelected = sender == btnFemale
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        //wrong
        self.showLoader()
        sendValidations()
    }
}


//MARK: - TextField Delegate
extension RegisterViewController: UITextFieldDelegate{
    
    //wrong
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case tfFirstName:
            textField.resignFirstResponder()
            tfLastName.becomeFirstResponder()
        case tfLastName:
            textField.resignFirstResponder()
            tfEmail.becomeFirstResponder()
        case tfEmail:
            textField.resignFirstResponder()
            tfPassword.becomeFirstResponder()
        case tfPassword:
            textField.resignFirstResponder()
            tfConfirmPassword.becomeFirstResponder()
        case tfConfirmPassword:
            textField.resignFirstResponder()
        case tfPhoneNumber:
            textField.resignFirstResponder()
        default:
            return false
        }
        return true
    }
}

//MARK: - RegisterViewModelDelegate
extension RegisterViewController: RegisterViewModelDelegate{
    //wronng
    func showAlert(msg:String) {
        DispatchQueue.main.async {
            self.hideLoader()
            if msg == "Registered Successfully"{
                self.showSingleButtonAlert(title: "Alert", msg: msg) {
                    let nextViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }  else {
                self.showSingleButtonAlert(title: "Alert", msg: msg, okClosure: nil)
            }
        }
    }
}
