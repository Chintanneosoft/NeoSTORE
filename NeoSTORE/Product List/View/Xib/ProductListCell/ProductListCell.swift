//
//  ProductListCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class ProductListCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
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
