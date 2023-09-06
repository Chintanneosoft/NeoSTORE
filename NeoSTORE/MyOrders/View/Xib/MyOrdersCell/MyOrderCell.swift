//
//  MyOrderCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

import UIKit

class MyOrderCell: UITableViewCell {

    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var lblOrderDate: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDetails(orderId: Int,orderDate: String, orderPrice: Int){
        lblOrderID.text = "Order ID : " + String(orderId)
        lblOrderDate.text = "Ordered Date: " + orderDate
        lblPrice.text = "₹" + String(orderPrice)
    }
}
