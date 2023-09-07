//
//  ProfileViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 27/08/23.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet var containerViews: [UIView]!
    
    @IBOutlet weak var tfFirstName: UITextField!
    
    @IBOutlet weak var tfLastName: UITextField!
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPhone: UITextField!
    
    @IBOutlet weak var tfDOB: UITextField!
    
    @IBOutlet weak var btnEditProflie: UIButton!
    
    @IBOutlet weak var btnRestPassword: UIButton!
    
    var userData : FetchUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        setUpNavBar()
    }
    private func setUpUI(){
        //Views
        for v in containerViews{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        
        tfFirstName.text = userData?.data?.user_data?.first_name
        tfLastName.text = userData?.data?.user_data?.last_name
        tfEmail.text = userData?.data?.user_data?.email
        tfPhone.text = userData?.data?.user_data?.phone_no
        tfDOB.text = userData?.data?.user_data?.dob
        profileImg.sd_setImage(with: URL(string: userData?.data?.user_data?.profile_pic ?? ""))
        
        tfDOB.isEnabled = false
        tfEmail.isEnabled = false
        tfPhone.isEnabled = false
        tfLastName.isEnabled = false
        tfFirstName.isEnabled = false
        
        tfDOB.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfPhone.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfEmail.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfLastName.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfFirstName.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        
        tfDOB.attributedPlaceholder = NSAttributedString(string: "DOB", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfPhone.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfLastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfFirstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        tfDOB.textColor = UIColor(named: "Primary Foreground")
        tfEmail.textColor = UIColor(named: "Primary Foreground")
        tfPhone.textColor = UIColor(named: "Primary Foreground")
        tfLastName.textColor = UIColor(named: "Primary Foreground")
        tfFirstName.textColor = UIColor(named: "Primary Foreground")
        
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        
    }
    func setUpNavBar(){
        
        navigationController?.navigationBar.isHidden = false
        
        
        navigationItem.title = "My Account"
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
    @IBAction func btnEditProfileTapped(_ sender: UIButton) {
        
        if btnEditProflie.titleLabel?.text != "SUBMIT" {
            
        }
        tfDOB.isEnabled = true
        tfEmail.isEnabled = true
        tfPhone.isEnabled = true
        tfLastName.isEnabled = true
        tfFirstName.isEnabled = true
        btnRestPassword.isHidden = true
        btnEditProflie.titleLabel?.text = "SUBMIT"
        
        navigationItem.title = "My Account"
    }
    
    @IBAction func btnResetPasswordTapped(_ sender: UIButton) {
        
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
