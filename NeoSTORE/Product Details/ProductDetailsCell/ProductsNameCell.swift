//
//  ProductsNameCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 25/08/23.
//

import UIKit
//MARK: - ProductsNameCell
class ProductsNameCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProducer: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet var btnRatings: [UIButton]!
    
    //MARK: - AwakefromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Functions
    func setUpUI(){
        lblProductName.font = UIFont(name: Font.fontRegular.rawValue, size: 19)
        lblCategory.font = UIFont(name: Font.fontThin.rawValue, size: 16)
        lblProducer.font = UIFont(name: Font.fontRegular.rawValue, size: 10)
    }
    
    func setDetails(productName: String, producerName: String, category: String, rating: Int){
        lblProductName.text = productName
        lblCategory.text = category
        lblProducer.text = producerName
        setRatings(rating: rating)
    }
    
    private func setRatings(rating:Int){
        var cnt: Int = 0
        for btn in btnRatings{
            if cnt < rating {
                btn.isSelected = true
            }
            else{
                break
            }
            cnt+=1
        }
    }
}
