import UIKit
import SDWebImage

//MARK: - ProductListCell
class ProductListCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProducer: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet var btnRatings: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI(){
        lblProductName.font =  UIFont.customFont(Font.fontRegular, size: 15)
        lblProducer.font = UIFont.customFont(Font.fontThin, size: 10)
        lblPrice.font = UIFont.customFont(Font.fontRegular, size: 20)
    }
    
    func setDetails(productImgName: String, productName: String, producerName: String, price: Int, rating: Int){
        lblProductName.text = productName
        lblPrice.text = "Rs: " + String(price)
        lblProducer.text = producerName
        setRatings(rating: rating)
        setImage(url: URL(string: productImgName)!)
    }
    
    private func setRatings(rating: Int){
        var cnt: Int = 0
        for btn in btnRatings{
            btn.isSelected = false
        }
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
}
