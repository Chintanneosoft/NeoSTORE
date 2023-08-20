//
//  HeaderCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class HeaderCell: UITableViewCell {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    func setUpUI(){
        lblName.font = UIFont(name:Font.fontRegular.rawValue,size: 23)
        lblEmail.font = UIFont(name:Font.fontThin.rawValue,size: 13)
    }
    
    func setDetails(imgName: String,name: String,email: String){
//        lblName.text = name
//        profileImg.image = UIImage(named: imgName)
//        lblEmail.text = email
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
