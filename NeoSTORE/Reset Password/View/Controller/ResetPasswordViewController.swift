//
//  ResetPasswordViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 25/08/23.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet var containerViews: [UIView]!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    
    @IBOutlet weak var btnResetPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelegates()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
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
        
        //Labels
        lblHeader.font = UIFont(name: Font.fontBold.rawValue, size: 45)
        
        //TextFields
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    //MARK: - @objc
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
        if textField == tfCurrentPassword{
            textField.resignFirstResponder()
            tfNewPassword.becomeFirstResponder()
        }
        if textField == tfNewPassword{
            textField.resignFirstResponder()
            tfConfirmPassword.becomeFirstResponder()
        }
        if textField == tfConfirmPassword{
            textField.resignFirstResponder()
        }
        return true
    }
}
//MARK: - ResetPasswordViewModelDelegate
extension ResetPasswordViewController: ResetPasswordViewModelDelegate{
    
    func showAlert(msg:String) {
        
        DispatchQueue.main.async {
            self.hideLoader()
            let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            
            if msg == "Password updated successfully"{
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
               
            } else {
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(action)
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}


