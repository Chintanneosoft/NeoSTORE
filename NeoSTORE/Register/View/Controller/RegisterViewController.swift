//
//  RegisterViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 17/08/23.
//

import UIKit

//MARK: - RegisterViewController
class RegisterViewController: UIViewController {

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
    
    var loaderView: UIView?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelegates()
    }
    
    //MARK: - Functions
    private func setUpUI(){
        //Navigation bar
        
        navigationController?.navigationBar.isHidden = false
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
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
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func btnRadioTapped(_ sender: UIButton) {
        
        if sender == btnMale{
            btnMale.isSelected = true
            btnFemale.isSelected = false
        }
        else{
            btnMale.isSelected = false
            btnFemale.isSelected = true
        }
        
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        self.showLoader(view: self.view, aicView: &self.loaderView)
        sendValidations()
    }
    
}


//MARK: - TextField Delegate
extension RegisterViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfFirstName{
            textField.resignFirstResponder()
            tfLastName.becomeFirstResponder()
        }
        if textField == tfLastName{
            textField.resignFirstResponder()
            tfEmail.becomeFirstResponder()
        }
        if textField == tfEmail{
            textField.resignFirstResponder()
            tfPassword.becomeFirstResponder()
        }
        if textField == tfPassword{
            textField.resignFirstResponder()
            tfConfirmPassword.becomeFirstResponder()
        }
        if textField == tfConfirmPassword{
            textField.resignFirstResponder()
        }
        if textField == tfPhoneNumber{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfPhoneNumber{
            textField.keyboardType = .numberPad
        }
    }
}

//MARK: - RegisterViewModelDelegate
extension RegisterViewController: RegisterViewModelDelegate{
    
    func showAlert(msg:String) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            if msg == "Registered Successfully"{
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let windows = windowScene.windows
                    windows.first?.rootViewController = UINavigationController(rootViewController: HomeContainerViewController())
                    windows.first?.makeKeyAndVisible()
                }
                
                
            }  else {
                
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                
                alert.addAction(action)
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
