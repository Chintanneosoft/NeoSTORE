import UIKit
import SDWebImage
import MobileCoreServices
import UniformTypeIdentifiers

//MARK: - ProfileViewController
class ProfileViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var btnEditProflie: UIButton!
    @IBOutlet weak var btnRestPassword: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet var txtCollection: [UITextField]!
    
    
    //MARK: - properties
    private var datePicker: UIDatePicker!
    var userData : FetchUser?
    var userImg: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken.rawValue) ?? ""
    var userImgData : Data?
    var extraHeight = 0
    var editState = false
    let profileViewModel = ProfileViewModel()
    
    //MARK: - Locally Saved Image
    let imageName = (UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken.rawValue) ?? "") + ".jpg"
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setDatePicker()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return ProfileViewController(nibName: ViewControllerString.Profile.rawValue, bundle: nil)
    }
    
    private func setDelegates(){
        tfDOB.delegate = self
        tfEmail.delegate = self
        tfPhone.delegate = self
        tfLastName.delegate = self
        tfFirstName.delegate = self
    }
    
    //MARK: - Navbar
    private func setUpNavBar(){
        
        navigationController?.navigationBar.isHidden = false
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = ScreenText.Profile.navTitle.rawValue
    }
    
    //MARK: - Set Up UI
    private func setUpUI(){
        
        //Text Fields
        for (index,txtv) in txtCollection.enumerated(){
            txtv.layer.borderWidth = 1.0
            txtv.layer.borderColor = UIColor.customColor(Color.primaryForeground).cgColor
            txtv.isEnabled = false
            txtv.font = UIFont.customFont(Font.fontRegular, size: 18)
            txtv.setPlaceholder(profileViewModel.txtFieldData[index][0])
            txtv.textColor = UIColor.customColor(Color.primaryForeground)
            txtv.setIcon((UIImage(named: profileViewModel.txtFieldData[index][1]) ?? UIImage(systemName: "user"))!)
        }
        
        tfFirstName.text = userData?.data?.user_data?.first_name
        tfLastName.text = userData?.data?.user_data?.last_name
        tfEmail.text = userData?.data?.user_data?.email
        tfPhone.text = userData?.data?.user_data?.phone_no
        tfDOB.text = userData?.data?.user_data?.dob
        
        //Image
        if let img = userData?.data?.user_data?.profile_pic{
            profileImg.sd_setImage(with: URL(string: img))
        }
        
        //MARK: - Locally Saved Image Fetch
        profileImg.image = loadProfileImage(imageName: UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken.rawValue) ?? "")
        
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        profileImg.addGestureRecognizer(imgTap)
        
        //Buttons
        btnEditProflie.layer.cornerRadius = 5
        btnEditProflie.titleLabel?.font = UIFont.customFont(Font.fontRegular, size: 18)
        btnRestPassword.titleLabel?.font = UIFont.customFont(Font.fontRegular, size: 18)
        btnCancel.layer.cornerRadius = 5
        btnCancel.titleLabel?.font = UIFont.customFont(Font.fontRegular, size: 18)
        
        mainScrollView = profileScrollView
    }
    
    
    //MARK: - Date Picker
    func setDatePicker(){
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: ScreenText.Profile.done.rawValue, style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        tfDOB.inputView = datePicker
        tfDOB.inputAccessoryView = toolbar
    }
    
    func updateDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let selectedDate = datePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        tfDOB.text = formattedDate
    }
    
    func callUpdateUser(){
        showLoader()
        profileViewModel.profileViewModelDelegate = self
        profileViewModel.callValidations(fname: tfFirstName.text ?? "", lname: tfLastName.text ?? "", email: tfEmail.text ?? "", dob: tfDOB.text ?? "" , profilePic: userImg , phone: tfPhone.text ?? "")
    }
    
    func actionOptions(){
        let alert = UIAlertController(title: ScreenText.Profile.chooseOption.rawValue, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: ScreenText.Profile.camera.rawValue, style: .default,handler: { handler in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: ScreenText.Profile.gallery.rawValue, style: .default,handler: { handler in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: ScreenText.Profile.cancel.rawValue, style: .default,handler: { handler in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.sourceType = .camera
            image.delegate = self
            self.present(image, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.delegate = self
            self.present(image, animated: true,completion:nil)
        }
    }
    
    func changeState(_ sender: UIButton){
        editState = !editState
        
        tfDOB.isEnabled = editState
        tfEmail.isEnabled = editState
        tfPhone.isEnabled = editState
        tfLastName.isEnabled = editState
        tfFirstName.isEnabled = editState
        btnRestPassword.isHidden = editState
        profileImg.isUserInteractionEnabled = editState
        btnCancel.isHidden = !editState
        editState ? btnEditProflie.setTitle(ScreenText.Profile.submit.rawValue, for: .normal) :
        btnEditProflie.setTitle(ScreenText.Profile.editProfile.rawValue, for: .normal)
        
        if !editState {
            if sender == btnEditProflie{
                saveImage(image: profileImg.image!, withName: imageName)
                callUpdateUser()
            }
            else{
                profileImg.image = loadProfileImage(imageName: imageName)
            }
        }
    }
    
    //MARK: - @objc Functions
    @objc func imgTapped(){
        tfFirstName.resignFirstResponder()
        actionOptions()
    }
    
    @objc func doneButtonTapped() {
        tfDOB.resignFirstResponder()
    }
    
    @objc func datePickerValueChanged() {
        updateDate()
    }
    
    //MARK: - IBActions
    @IBAction func btnEditProfileTapped(_ sender: UIButton) {
        changeState(sender)
    }
    
    @IBAction func btnResetPasswordTapped(_ sender: UIButton) {
        let profileViewController = ResetPasswordViewController.loadFromNib()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        changeState(sender)
        setUpUI()
    }
}

//MARK: - TextFieldDelegate
extension ProfileViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfDOB{
            extraHeight = 60
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfDOB{
            extraHeight = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case tfFirstName:
            textField.resignFirstResponder()
            tfLastName.becomeFirstResponder()
        case tfLastName:
            textField.resignFirstResponder()
            tfEmail.becomeFirstResponder()
        case tfEmail:
            textField.resignFirstResponder()
            tfPhone.becomeFirstResponder()
        case tfPhone:
            textField.resignFirstResponder()
            tfDOB.becomeFirstResponder()
        default :
            return false
        }
        return true
    }
}

//MARK: - ImagePickerController Delegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editingImg = info[.editedImage] as? UIImage{
            
            if let imgData = editingImg.jpegData(compressionQuality: 0.8){
                let base64String = imgData.base64EncodedString()
                self.userImgData = imgData
                self.userImg = base64String
            }
            
            if let data = Data(base64Encoded: userImg ) {
                if let image = UIImage(data: data) {
                    self.profileImg.image = image
                }
            }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}

//MARK: - ProfileViewModelDelegate
extension ProfileViewController: ProfileViewModelDelegate{
    func setUserData() {
        DispatchQueue.main.async {
            self.hideLoader()
            NotificationCenter.default.post(name: .updateDrawer, object: nil)
        }
    }
    func failureUser(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
        }
    }
}
