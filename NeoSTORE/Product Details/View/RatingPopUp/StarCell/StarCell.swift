import UIKit

class StarCell: UICollectionViewCell {

    @IBOutlet weak var starImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setStar(selected: Bool){
        starImg.image = selected ? UIImage(named: "star_check"): UIImage(named: "star_unchek")
    }
}
