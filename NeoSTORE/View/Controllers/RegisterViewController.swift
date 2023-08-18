//
//  RegisterViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 17/08/23.
//

import UIKit

class RegisterViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    func setUpUI(){
        navigationItem.title = "Register"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Font.fontRegular.rawValue, size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
              ]
        
        let leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(leftBarButtonTapped))
        leftBarButtonItem.tintColor = UIColor(named: "Primary Foreground")

        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        lblHeading.font = UIFont(name: Font.fontBold.rawValue, size: 45)
        lblTermsAndConditions.font = UIFont(name: Font.fontBold.rawValue, size: 13)
        
        for v in containerView{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        
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
        
        btnRegister.titleLabel?.font =  UIFont(name: Font.fontRegular.rawValue, size: 26)
        btnRegister.layer.cornerRadius = 5.0
        
        
    }
    
    @objc func leftBarButtonTapped() {
           // Handle left button tap
        navigationController?.popViewController(animated: true)
       }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
