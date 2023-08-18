//
//  SliderCollectionViewCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 18/08/23.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var sliderImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImg(imgName: String){
        sliderImg?.image = UIImage(named: imgName)
    }
}
