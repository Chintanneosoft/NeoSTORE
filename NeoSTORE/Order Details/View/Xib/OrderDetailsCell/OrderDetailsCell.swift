import UIKit
import SDWebImage

//MARK: - OrderDetailsCell
class OrderDetailsCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblproductName: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDetails(imgURL: String,productName: String,productCategory: String, quantity:Int, price: Int){
        lblproductName.text = productName
        lblProductCategory.text = productCategory
        lblQuantity.text = "QTY :" + String(quantity)
        lblProductPrice.text = "₹" + String(price)
        productImg.sd_setImage(with: URL(string: imgURL))
    }
}
