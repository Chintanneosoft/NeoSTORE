import UIKit
import SDWebImage

//MARK: - ProductImageCollectionViewCell
class ProductImageCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var productImgs: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImg(url: String){
        let imgUrl = URL(string: url )
        productImgs.sd_setImage(with: imgUrl)
    }
}
