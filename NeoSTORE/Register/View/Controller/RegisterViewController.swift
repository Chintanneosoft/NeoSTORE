import UIKit

//MARK: - RegisterViewController
class RegisterViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblTermsAndConditions: UILabel!
    @IBOutlet var genderView: UIView!
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
    @IBOutlet var txtCollection: [UITextField]!
    
    let registerViewModel = RegisterViewModel()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        registerScrollView.isScrollEnabled = isiPhoneSE()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return RegisterViewController(nibName: ViewControllerString.Register.rawValue, bundle: nil)
    }
    
    private func setUpUI(){
        //Navigation bar\
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        
        navigationItem.title = ScreenText.Register.navTitle.rawValue
        
        //Labels
        lblHeading.font = UIFont.customFont(Font.fontBold, size: 45)
        lblTermsAndConditions.font = UIFont.customFont(Font.fontBold, size: 13)
        
        //TextFields
        for (index,txtv) in txtCollection.enumerated(){
            txtv.layer.borderWidth = 1.0
            txtv.layer.borderColor = UIColor.customColor(Color.primaryForeground).cgColor
            txtv.font = UIFont.customFont(Font.fontRegular, size: 18)
            txtv.textColor = UIColor.customColor(Color.primaryForeground)
            txtv.setPlaceholder(registerViewModel.txtFieldData[index][0])
            txtv.setIcon(UIImage(named: registerViewModel.txtFieldData[index][1])!)
        }
        
        //Buttons
        btnRegister.titleLabel?.font = UIFont.customFont(Font.fontRegular, size: 26)
        btnRegister.layer.cornerRadius = 5.0
        mainScrollView = registerScrollView
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
        registerViewModel.callValidations(fname: tfFirstName.text ?? "", lname: tfLastName.text ?? "", email: tfEmail.text ?? "", pass: tfPassword.text ?? "", cpass: tfConfirmPassword.text ?? "", phone: tfPhoneNumber.text ?? "", btnSelected:btnMale.isSelected ? ScreenText.Register.male.rawValue : (btnFemale.isSelected ? ScreenText.Register.female.rawValue : ""), termsAndCondition: termsAndCondition.isSelected)
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
    func showAlert(result:Bool,msg:String) {
        DispatchQueue.main.async {
            self.hideLoader()
            if result{
                self.showSingleButtonAlert(title: AlertText.Title.success.rawValue, msg: msg) {
                    let nextViewController = LoginViewController.loadFromNib()
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }  else {
                self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
            }
        }
    }
}
