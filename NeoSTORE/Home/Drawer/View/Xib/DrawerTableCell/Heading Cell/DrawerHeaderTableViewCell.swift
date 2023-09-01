//
//  DrawerHeaderTableViewCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit
import SDWebImage
class DrawerHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    private func setUpUI(){
        lblName.font = UIFont(name:Font.fontRegular.rawValue,size: 23)
        lblEmail.font = UIFont(name:Font.fontThin.rawValue,size: 13)
    }
    
    func setDetails(imgName: String,name: String,email: String){
        lblName.text = name
        lblEmail.text = email
        profileImg.sd_setImage(with: URL(string: imgName))
    }
}
