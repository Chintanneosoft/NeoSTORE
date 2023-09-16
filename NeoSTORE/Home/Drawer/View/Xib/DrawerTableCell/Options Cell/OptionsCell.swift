import UIKit
import SDWebImage

//MARK: - OptionsCell
class OptionsCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var optionImg: UIImageView!
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    private func setUpUI(){
        lblOption.font = UIFont(name:Font.fontRegular.rawValue,size: 16)
        lblNotification.font = UIFont(name:Font.fontThin.rawValue,size: 13)
        lblNotification.layer.cornerRadius = lblNotification.bounds.width/2
    }
    
    func setDetails(optionImg: String,optionName: String,noOfNotifications: Int){
        lblOption.text = optionName
        if noOfNotifications > 0{
            lblNotification.isHidden = false
        }
        else{
            lblNotification.isHidden = true
        }
        lblNotification.text = String(noOfNotifications)
        self.optionImg.image = UIImage(named: optionImg)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
