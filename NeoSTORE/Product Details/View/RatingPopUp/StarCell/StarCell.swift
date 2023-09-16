//
//  StarCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 15/09/23.
//

import UIKit

class StarCell: UICollectionViewCell {

    @IBOutlet weak var starImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setStar(selected: Bool){
        starImg.image = selected ? UIImage(named: "star_check"): UIImage(named: "star_unchek")
    }
}
