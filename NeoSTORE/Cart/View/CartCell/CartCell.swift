//
//  CartCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 01/09/23.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblProductCategory: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
