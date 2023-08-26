//
//  ProductsNameCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 25/08/23.
//

import UIKit

class ProductsNameCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProducer: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnRating1: UIButton!
    @IBOutlet weak var btnRating2: UIButton!
    @IBOutlet weak var btnRating3: UIButton!
    @IBOutlet weak var btnRating4: UIButton!
    @IBOutlet weak var btnRating5: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetails(imgName: String, productName: String, producerName: String, price: Int){
        lblProductName.text = productName
        lblPrice.text = "Rs: " + String(price)
        lblProducer.text = producerName
        setImage(url:imgName)
    }
    private func setImage(url:String){
      
        
    }
}
