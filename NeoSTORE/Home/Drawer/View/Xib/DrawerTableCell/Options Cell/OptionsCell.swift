//
//  OptionsCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class OptionsCell: UITableViewCell {

    
    @IBOutlet weak var optionImg: UIImageView!
    
    @IBOutlet weak var lblOption: UILabel!
    
    @IBOutlet weak var lblNotification: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    func setUpUI(){
        lblOption.font = UIFont(name:Font.fontRegular.rawValue,size: 16)
        lblNotification.font = UIFont(name:Font.fontThin.rawValue,size: 13)
        lblNotification.layer.cornerRadius = 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
