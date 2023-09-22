import UIKit

class StarCell: UICollectionViewCell {

    @IBOutlet weak var starImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setStar(selected: Bool){
        starImg.image = selected ? UIImage(named: ImageNames.starCheck.rawValue): UIImage(named: ImageNames.starUncheck.rawValue)
    }
}
