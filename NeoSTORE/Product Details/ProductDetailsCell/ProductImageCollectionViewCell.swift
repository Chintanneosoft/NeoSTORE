//
//  ProductImageCollectionViewCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 28/08/23.
//

import UIKit
import SDWebImage

class ProductImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImgs: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setImg(url: String){
        let imgUrl = URL(string: url )
        productImgs.sd_setImage(with: imgUrl)
    }
}
