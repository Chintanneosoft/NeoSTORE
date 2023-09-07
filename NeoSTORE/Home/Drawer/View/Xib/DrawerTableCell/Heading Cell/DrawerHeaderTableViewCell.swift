//
//  DrawerHeaderTableViewCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit
import SDWebImage

protocol DrawerHeaderTableViewCellDelegate: NSObject{
    func goToProfile()
}

class DrawerHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
     
    weak var drawerHeaderTableViewCellDelegate : DrawerHeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    private func setUpUI(){
        
        lblName.font = UIFont(name:Font.fontRegular.rawValue,size: 23)
        lblEmail.font = UIFont(name:Font.fontThin.rawValue,size: 13)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        lblName.addGestureRecognizer(tap1)
        lblName.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        lblEmail.addGestureRecognizer(tap2)
        lblEmail.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileImg.addGestureRecognizer(tap3)
        profileImg.isUserInteractionEnabled = true
        
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        profileImg.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        profileImg.layer.borderWidth = 2
        
    }
    
    func setDetails(imgName: String,name: String,email: String){
        lblName.text = name
        lblEmail.text = email
        profileImg.sd_setImage(with: URL(string: imgName))
    }
    
    @objc func profileTapped(){
        drawerHeaderTableViewCellDelegate?.goToProfile()
    }
}
