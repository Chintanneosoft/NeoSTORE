import UIKit
import SDWebImage

//MARK: - UpdateQuantity Protocol
protocol UpdateQuantity: NSObject{
    func changeDropDownState(productId: Int,quantity: String)
}

//MARK: - CartCell
class CartCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQunatity: UILabel!
    @IBOutlet weak var imgDropdown: UIImageView!
    
    weak var updateQuantityDelegate: UpdateQuantity?
    var productId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped) )
        imgDropdown.addGestureRecognizer(tap)
        imgDropdown.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDetails(imgUrl: String, productName: String, productCategory: String, price: Int,quantity:Int,productID:Int){
        lblPrice.text = "₹" + String(price)
        lblProductName.text = productName
        lblProductCategory.text = "(" + productCategory + ")"
        productImg.sd_setImage(with: URL(string: imgUrl))
        lblQunatity.text = String(quantity)
        productId = productID
    }
    
    @objc func imgTapped(){
        updateQuantityDelegate?.changeDropDownState(productId: productId ?? 0, quantity: lblQunatity.text ?? "")
    }
}
