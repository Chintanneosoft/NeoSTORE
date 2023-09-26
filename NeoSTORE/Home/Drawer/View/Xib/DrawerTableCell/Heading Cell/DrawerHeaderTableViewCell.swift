import UIKit
import SDWebImage

//MARK: - DrawerHeaderTableViewCellDelegate
protocol DrawerHeaderTableViewCellDelegate: NSObject{
    func goToProfile()
}

//MARK: - DrawerHeaderTableViewCell
class DrawerHeaderTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
     
    weak var drawerHeaderTableViewCellDelegate : DrawerHeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI(){
        
        lblName.font = UIFont.customFont(Font.fontRegular, size: 23)
        lblEmail.font = UIFont.customFont(Font.fontThin, size: 13)
        
        //wrong
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
//        lblName.addGestureRecognizer(tap1)
//        lblName.isUserInteractionEnabled = true
//        let tap2 = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
//        lblEmail.addGestureRecognizer(tap2)
//        lblEmail.isUserInteractionEnabled = true
//        let tap3 = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
//        profileImg.addGestureRecognizer(tap3)
//        profileImg.isUserInteractionEnabled = true
        
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        profileImg.layer.borderColor = UIColor.customColor(Color.primaryForeground).cgColor
        profileImg.layer.borderWidth = 2
        
    }
    
    func setDetails(imgName: String,name: String,email: String){
        lblName.text = name
        lblEmail.text = email
        profileImg.sd_setImage(with: URL(string: imgName))
        if UserDefaultsKeys.accessToken.rawValue == ""{
            profileImg.image = UIImage(systemName: ImageNames.person.rawValue)
        } else {
            profileImg.image = loadProfileImage(imageName: UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken.rawValue) ?? "")
        }
    }
    
    @objc func profileTapped(){
        drawerHeaderTableViewCellDelegate?.goToProfile()
    }
}
