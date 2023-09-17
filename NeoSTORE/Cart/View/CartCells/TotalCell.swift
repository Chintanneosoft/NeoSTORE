import UIKit

class TotalCell: UITableViewCell {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var ltlTotalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpUI()
    }
    
    private func setUpUI(){
        lblTotal.font = UIFont(name: Font.fontRegular.rawValue, size: 20)
    }
    
    func setDetails(totalPrice: Int){
        ltlTotalPrice.text = "₹" + String(totalPrice)
    }
}
