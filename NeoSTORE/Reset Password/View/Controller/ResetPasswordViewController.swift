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
        // Do any additional setup after loading the view.
        
    }
    
    private func setUpUI(){
        
        //Labels
        lblHeader.font = UIFont(name: Font.fontBold.rawValue, size: 45)
        
        //TextFields
        tfCurrentPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfCurrentPassword.textColor = UIColor(named: "Primary Foreground")
        tfCurrentPassword.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Current Password")!])
        tfNewPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfNewPassword.textColor = UIColor(named: "Primary Foreground")
        tfNewPassword.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfConfirmPassword.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfConfirmPassword.textColor = UIColor(named: "Primary Foreground")
        tfConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        btnResetPassword.titleLabel?.font =  UIFont(name: Font.fontRegular.rawValue, size: 26)
        btnResetPassword.layer.cornerRadius = 5.0
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
