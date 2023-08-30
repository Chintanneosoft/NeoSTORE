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
    
    @IBOutlet var btnRatings: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    func setUpUI(){
        lblProductName.font = UIFont(name: Font.fontRegular.rawValue, size: 15)
        lblProducer.font = UIFont(name: Font.fontThin.rawValue, size: 10)
        lblPrice.font = UIFont(name: Font.fontRegular.rawValue, size: 20)
//        lblProductName.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
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
