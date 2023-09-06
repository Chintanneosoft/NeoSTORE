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
    
    @IBOutlet weak var lblFirstName: UILabel!
    
    @IBOutlet weak var lblLastName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblDOB: UILabel!
    
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
    }
    private func setUpUI(){
        //Views
        for v in containerViews{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        
        lblFirstName.text = userData?.data?.user_data?.first_name
        lblLastName.text = userData?.data?.user_data?.last_name
        lblEmail.text = userData?.data?.user_data?.email
        lblPhone.text = userData?.data?.user_data?.phone_no
        lblDOB.text = userData?.data?.user_data?.dob
        profileImg.sd_setImage(with: URL(string: userData?.data?.user_data?.profile_pic ?? ""))
    }
    
    @IBAction func btnEditProfileTapped(_ sender: UIButton) {
        let nextViewController = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
