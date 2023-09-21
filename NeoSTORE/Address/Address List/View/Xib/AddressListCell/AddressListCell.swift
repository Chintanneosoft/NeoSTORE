import UIKit

//MARK: - AddressListCellDelegate Protocol
protocol AddressListCellDelegate: NSObject{
    func btnSelectTapped(btnTag: Int)
    func btnCancelTapped(btnTag: Int)
}

//MARK: - AddressListCell
class AddressListCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    //addressListCell Delegate
    weak var addressListCellDelegate: AddressListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpUI(){
        lblTitle.font = UIFont.customFont(Font.fontRegular, size: 22)
        lblAddress.font = UIFont.customFont(Font.fontThin, size: 15)
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 0.1
    }
    
    @IBAction func btnSelectTapped(_ sender: UIButton) {
        addressListCellDelegate?.btnSelectTapped(btnTag: sender.tag)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        addressListCellDelegate?.btnCancelTapped(btnTag: sender.tag)
        
    }
    
}
