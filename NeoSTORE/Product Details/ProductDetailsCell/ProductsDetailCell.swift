//
//  ProductsDetailCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 25/08/23.
//

import UIKit

class ProductsDetailCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOutOfStock: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
