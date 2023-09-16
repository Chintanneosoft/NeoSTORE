//
//  ProfileViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 27/08/23.
//

import UIKit
import SDWebImage
import MobileCoreServices
import UniformTypeIdentifiers


//MARK: - ProfileViewController
class ProfileViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var btnEditProflie: UIButton!
    @IBOutlet weak var btnRestPassword: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var profileScrollView: UIScrollView!
    
    
    //MARK: - properties
    private var datePicker: UIDatePicker!
    
    var userData : FetchUser?
    var userImg: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    var userImgData : Data?
    
    var extraHeight = 0
    var editState = false
    
    let profileViewModel = ProfileViewModel()
    
    //MARK: - Locally Saved Image
    let imageName = (UserDefaults.standard.string(forKey: "accessToken") ?? "") + ".jpg"
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setDatePicker()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    
    //MARK: - Functions
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
        navigationItem.title = "My Account"
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
    
    //MARK: - Set Up UI
    private func setUpUI(){
        
        //Views
        for v in containerViews{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        
        //Text Fields
        tfFirstName.text = userData?.data?.user_data?.first_name
        tfLastName.text = userData?.data?.user_data?.last_name
        tfEmail.text = userData?.data?.user_data?.email
        tfPhone.text = userData?.data?.user_data?.phone_no
        tfDOB.text = userData?.data?.user_data?.dob
        
        tfDOB.isEnabled = false
        tfEmail.isEnabled = false
        tfPhone.isEnabled = false
        tfLastName.isEnabled = false
        tfFirstName.isEnabled = false
        
        tfDOB.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfPhone.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfEmail.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfLastName.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        tfFirstName.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        
        tfDOB.attributedPlaceholder = NSAttributedString(string: "DOB", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfPhone.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfLastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        tfFirstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!])
        
        tfDOB.textColor = UIColor(named: "Primary Foreground")
        tfEmail.textColor = UIColor(named: "Primary Foreground")
        tfPhone.textColor = UIColor(named: "Primary Foreground")
        tfLastName.textColor = UIColor(named: "Primary Foreground")
        tfFirstName.textColor = UIColor(named: "Primary Foreground")
        
        //Image
        if let img = userData?.data?.user_data?.profile_pic{
            profileImg.sd_setImage(with: URL(string: img))
        }
        
        //MARK: - Locally Saved Image Fetch
        profileImg.image = loadProfileImage(imageName: UserDefaults.standard.string(forKey: "accessToken") ?? "")
        
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        profileImg.addGestureRecognizer(imgTap)
        
        //Buttons
        btnEditProflie.layer.cornerRadius = 5
        btnEditProflie.titleLabel?.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        btnRestPassword.titleLabel?.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        btnCancel.layer.cornerRadius = 5
        btnCancel.titleLabel?.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        btnCancel.titleLabel?.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        
        //Keyboard
    
        
        addObservers()
        
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        tfDOB.inputView = datePicker
        tfDOB.inputAccessoryView = toolbar
    }
    
    func updateDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Set the desired date format
        
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
        let alert = UIAlertController(title: "Choose Option", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default,handler: { handler in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default,handler: { handler in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default,handler: { handler in
            
        }))
        self.present(alert, animated: true)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                   let image = UIImagePickerController()
                   image.allowsEditing = true
                   image.sourceType = .camera
                   //image.mediaTypes = [kUTTypeImage as String]
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
        if editState {
            tfDOB.isEnabled = true
            tfEmail.isEnabled = true
            tfPhone.isEnabled = true
            tfLastName.isEnabled = true
            tfFirstName.isEnabled = true
            btnRestPassword.isHidden = true
            profileImg.isUserInteractionEnabled = true
            btnCancel.isHidden = false
            tfFirstName.becomeFirstResponder()
            // sender.titleLabel?.text = "SUBMIT"
            btnEditProflie.setTitle("SUBMIT", for: .normal)
            // navigationItem.title = "Edit Profile"
        }
        else {
            tfDOB.isEnabled = false
            tfEmail.isEnabled = false
            tfPhone.isEnabled = false
            tfLastName.isEnabled = false
            tfFirstName.isEnabled = false
            btnRestPassword.isHidden = false
            profileImg.isUserInteractionEnabled = false
            btnCancel.isHidden = true
            btnEditProflie.setTitle("EDIT PROFILE", for: .normal)
            //   navigationItem.title = "My Account"
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
        let profileViewController = ResetPasswordViewController(nibName: "ResetPasswordViewController", bundle: nil)
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
        if textField == tfFirstName{
            textField.resignFirstResponder()
            tfLastName.becomeFirstResponder()
        }
        if textField == tfLastName{
            textField.resignFirstResponder()
            tfEmail.becomeFirstResponder()
        }
        if textField == tfEmail{
            textField.resignFirstResponder()
            tfPhone.becomeFirstResponder()
        }
        if textField == tfPhone{
            textField.resignFirstResponder()
            tfDOB.becomeFirstResponder()
        }

        
        return true
    }
}

//MARK: - ImagePickerController Delegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        
        if let editingImg = info[.editedImage] as? UIImage{
            print(editingImg)
            
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
            self.showAlert(title: "Error", msg: msg)
        }
    }
}
