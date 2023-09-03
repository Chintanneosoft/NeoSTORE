//
//  TotalCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 02/09/23.
//

import UIKit

class TotalCell: UITableViewCell {

    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var ltlTotalPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDetails(totalPrice: Int){
        ltlTotalPrice.text = "₹" + String(totalPrice)
    }
}
