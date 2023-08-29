//
//  ProductListCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit
import SDWebImage
class ProductListCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProducer: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnRating1: UIButton!
    @IBOutlet weak var btnRating2: UIButton!
    @IBOutlet weak var btnRating3: UIButton!
    @IBOutlet weak var btnRating4: UIButton!
    @IBOutlet weak var btnRating5: UIButton!
    
    @IBOutlet var btnRatings: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDetails(productImgName: String, productName: String, producerName: String, price: Int, rating: Int){
        //        productImg.image = UIImage(named: productImgName)
        lblProductName.text = productName
        lblPrice.text = "Rs: " + String(price)
        lblProducer.text = producerName
        setRatings(rating: rating)
        setImage(url: URL(string: productImgName)!)
    }
    
    private func setRatings(rating: Int){
        var cnt: Int = 0
        for btn in btnRatings{
            if cnt<rating {
                btn.isSelected = true
            }
            else{
                break
            }
            cnt+=1
        }
    }
    
    private func setImage(url:URL) {
        productImg.sd_setImage(with: url )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
