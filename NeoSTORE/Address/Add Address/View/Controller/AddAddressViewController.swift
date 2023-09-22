import UIKit

//MARK: - AddAddressViewController
class AddAddressViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCity1: UILabel!
    @IBOutlet weak var lblCity2: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZipCode: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var tvAddress: UITextView!
    @IBOutlet weak var tfLandmark: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfZipCode: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var btnSaveAddress: UIButton!
    @IBOutlet weak var addAddressScrollView: UIScrollView!
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        setUpNavBar()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return AddAddressViewController(nibName: ViewControllerString.AddAddress.rawValue, bundle: nil)
    }
    
    private func setDelegates(){
        tvAddress.delegate = self
        tfCity.delegate = self
        tfState.delegate = self
        tfCountry.delegate = self
        tfZipCode.delegate = self
        tfLandmark.delegate = self
    }
    
    private func setUpUI(){
        mainScrollView = addAddressScrollView
        
        btnSaveAddress.layer.cornerRadius = 5
        btnSaveAddress.titleLabel?.font = UIFont.customFont(Font.fontBold, size: 20)
    }
    
    private func setUpNavBar(){
        //Navigation bar
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = ScreenText.AddAddress.navTitle.rawValue
    }
       
    //MARK: - IBActions
    @IBAction func btnSaveAddressTapped(_ sender: UIButton) {
        if tvAddress.text == "" || tfLandmark.text == "" || tfCity.text == "" || tfState.text == "" || tfCountry.text == "" || tfZipCode.text == ""{
            self.showSingleButtonAlert(title: AlertText.Title.alert.rawValue, msg: AlertText.Message.emptyFields.rawValue, okClosure: nil)
        }
        else {
            let address1 = tvAddress.text + " " + (tfLandmark.text ?? "") + " "
            let address2 = (tfCity.text ?? "") + " " + (tfZipCode.text ?? "") + " "
            let address3 = (tfState.text ?? "") + " " + (tfCountry.text ?? "")
            let address = address1 + address2 + address3
            UserDefaults.standard.set(address, forKey: UserDefaultsKeys.userAddress.rawValue)
            showSingleButtonAlert(title: AlertText.Title.success.rawValue, msg: AlertText.Message.addAddressSuccess.rawValue) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

//MARK: - TextField Delegate and Datasource
extension AddAddressViewController: UITextViewDelegate,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case tfLandmark:
            tfLandmark.resignFirstResponder()
            tfCity.becomeFirstResponder()
        case tfCity:
            tfCity.resignFirstResponder()
            tfState.becomeFirstResponder()
        case tfState:
            tfState.resignFirstResponder()
            tfZipCode.becomeFirstResponder()
        case tfZipCode:
            tfZipCode.resignFirstResponder()
            tfCountry.becomeFirstResponder()
        case tfCountry:
            tfCountry.resignFirstResponder()
        default:
            return false
        }
        return true
    }
}
