import UIKit

//MARK: - MyOrderCell
class MyOrderCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI(){
        lblOrderID.font = UIFont.customFont(Font.fontThin, size: 17)
        lblOrderDate.font = UIFont.customFont(Font.fontThin, size: 12)
        lblPrice.font = UIFont.customFont(Font.fontThin, size: 20)
    }
    
    func setDetails(orderId: Int,orderDate: String, orderPrice: Int){
        lblOrderID.text = ScreenText.MyOrders.orderID.rawValue + String(orderId)
        lblOrderDate.text = ScreenText.MyOrders.orderDate.rawValue + orderDate
        lblPrice.text = ScreenText.Common.rupees.rawValue + String(orderPrice)
    }
}
