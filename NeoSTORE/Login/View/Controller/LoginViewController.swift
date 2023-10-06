import UIKit

//MARK: - LoginViewController
class LoginViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var lblDontHaveAccount: UILabel!
    @IBOutlet var txtContainerViews: [UITextField]!
    //wrong
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnAddUserTapped: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    let loginViewModel = LoginViewModel()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return LoginViewController(nibName: ViewControllerString.Login.rawValue, bundle: nil)
    }
    
    private func setDelegates(){
        tfUsername.delegate = self
        tfPassword.delegate = self
    }
    
    //MARK: - SetUpUI
    private func setUpUI(){
        
        //Labels
        lblHeading.font = UIFont.customFont(Font.fontBold, size: 45)
        lblForgotPassword.font = UIFont.customFont(Font.fontBold, size: 18)
        lblDontHaveAccount.font = UIFont.customFont(Font.fontBold, size: 16)
        
        //TextFields Views
        for (index,txtv) in txtContainerViews.enumerated(){
            txtv.layer.borderWidth = 1.0
            txtv.layer.borderColor = UIColor.customColor(Color.primaryForeground).cgColor
            txtv.font = UIFont.customFont(Font.fontRegular, size: 18)
            txtv.textColor = UIColor.customColor(Color.primaryForeground)
            txtv.setPlaceholder(loginViewModel.txtFieldData[index][0])
            txtv.setIcon(UIImage(named: loginViewModel.txtFieldData[index][1])!)
        }
        
        //Buttons
        btnLogin.titleLabel?.font = UIFont.customFont(Font.fontRegular,size: 26)
        btnLogin.layer.cornerRadius = 5.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgotPassTapped))
        lblForgotPassword.addGestureRecognizer(tap)
        lblForgotPassword.isUserInteractionEnabled = true
        
        let backImgTap = UITapGestureRecognizer(target: self, action:#selector(forgotPassTapped) )
        backImg.addGestureRecognizer(backImgTap)
        backImg.isUserInteractionEnabled = true
    }
    
    //MARK: - Send Validations
    private func sendValidations(){
        let loginViewModel = LoginViewModel()
        loginViewModel.loginViewModelDelegate = self
        loginViewModel.callValidations(email: tfUsername.text ?? "", pass: tfPassword.text ?? "")
    }
    
    private func callForgotPass(){
        loginViewModel.loginViewModelDelegate = self
        loginViewModel.callForgotPass(email: tfUsername.text ?? "")
    }
    
    //Change UI to/from forgot and login screen
    private func changeUI(){
        tfPassword.text = ""
        tfUsername.text = ""
        
        let boolCondition = (lblForgotPassword.isHidden == false)
        tfPassword.isHidden = boolCondition
        lblForgotPassword.isHidden = boolCondition
        backImg.isHidden = !boolCondition
        btnLogin.setTitle((boolCondition ? ScreenText.Login.submitButton.rawValue : ScreenText.Login.loginButton.rawValue), for: .normal)
    }
    
    //MARK: - @objc
    @objc func forgotPassTapped(){
        changeUI()
    }
    
    //MARK: - IBActions
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        self.showLoader()
        if lblForgotPassword.isHidden{
            callForgotPass()
        } else {
            sendValidations()
        }
    }
    
    @IBAction func btnAddUserTapped(_ sender: UIButton) {
        if lblForgotPassword.isHidden{
            changeUI()
        }
        let nextViewController = RegisterViewController.loadFromNib()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

//MARK: - TextField Delegate
extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case tfUsername:
            textField.resignFirstResponder()
            tfPassword.becomeFirstResponder()
        case tfPassword:
            textField.resignFirstResponder()
        default:
            return false
        }
        return true
    }
}

//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate{
    
    func showAlert(result: Bool,msg:String) {
        DispatchQueue.main.async {
            self.hideLoader()
            if self.btnLogin.titleLabel?.text == ScreenText.Login.submitButton.rawValue{
                self.showSingleButtonAlert(title: AlertText.Title.alert.rawValue, msg: msg) {
                    self.changeUI()
                }
            } else {
                if result{
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let windows = windowScene.windows
                        windows.first?.rootViewController = UINavigationController(rootViewController: HomeContainerViewController.loadFromNib())
                        windows.first?.makeKeyAndVisible()
                    }
                } else {
                    self.showSingleButtonAlert(title: AlertText.Title.alert.rawValue, msg: msg, okClosure: nil)
                }
            }
        }
    }
}
