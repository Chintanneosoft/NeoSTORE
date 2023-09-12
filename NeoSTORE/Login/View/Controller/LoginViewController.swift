//
//  LoginViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 17/08/23.
//

import UIKit

//MARK: - LoginViewController
class LoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var lblDontHaveAccount: UILabel!
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnAddUserTapped: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegates()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Functions
    
    private func setDelegates(){
        tfUsername.delegate = self
        tfPassword.delegate = self
        
    }
    
    //MARK: - SetUpUI
    private func setUpUI(){
        
        //Labels
        lblHeading.font = UIFont(name: Font.fontBold.rawValue, size: 45)
        lblForgotPassword.font = UIFont(name: Font.fontBold.rawValue, size: 18)
        lblDontHaveAccount.font = UIFont(name: Font.fontBold.rawValue, size: 16)
        
        //Views
        for v in containerViews{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //TextFields
        tfUsername.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfUsername.textColor = UIColor(named: "Primary Foreground")
        tfUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfPassword.textColor = UIColor(named: "Primary Foreground")
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        //Buttons
        btnLogin.titleLabel?.font =  UIFont(name: Font.fontRegular.rawValue, size: 26)
        btnLogin.layer.cornerRadius = 5.0
        
        navigationItem.backButtonTitle = ""
        
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
        let loginViewModel = LoginViewModel()
        loginViewModel.loginViewModelDelegate = self
        loginViewModel.callForgotPass(email: tfUsername.text ?? "")
    }
    
    //Change UI to/from forgot and login screen
    private func changeUI(){
        if lblForgotPassword.isHidden == false{
            containerViews[1].isHidden = true
            lblForgotPassword.isHidden = true
            backImg.isHidden = false
            btnLogin.setTitle("SUBMIT", for:.normal)
        } else {
            lblForgotPassword.isHidden = false
            containerViews[1].isHidden = false
            backImg.isHidden = true
            btnLogin.setTitle("LOGIN", for:.normal)
        }
    }
    
    //MARK: - @objc
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func forgotPassTapped(){
        changeUI()
    }
    
    //MARK: - IBActions
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        if btnLogin.titleLabel?.text == "SUBMIT"{
            self.showLoader()
            callForgotPass()
        }
        else{
            self.showLoader()
            sendValidations()
        }
    }
    
    @IBAction func btnAddUserTapped(_ sender: UIButton) {
        if lblForgotPassword.isHidden == true{
            changeUI()
        }
        let nextViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

//MARK: - TextField Delegate
extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == tfUsername{
            textField.resignFirstResponder()
            tfPassword.becomeFirstResponder()
        }
        
        if textField == tfPassword{
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}

//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate{
    
    func showAlert(msg:String) {
        
        DispatchQueue.main.async {
            self.hideLoader()
            
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            
            if self.btnLogin.titleLabel?.text == "SUBMIT"{
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.changeUI()
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(action)

            }
            else{
                
                if msg == "LoggedIn Successfully"{
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let windows = windowScene.windows
                        windows.first?.rootViewController = UINavigationController(rootViewController: HomeContainerViewController())
                        windows.first?.makeKeyAndVisible()
                    }
                    
                    
                } else {
                    
                    let action = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                }
                
                            }
            self.present(alert, animated: true, completion: nil)

        }
    }
}


