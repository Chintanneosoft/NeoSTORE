//
//  ProfileViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 27/08/23.
//

import UIKit
import SDWebImage
import MobileCoreServices

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var btnEditProflie: UIButton!
    @IBOutlet weak var btnRestPassword: UIButton!
    @IBOutlet weak var profileScrollView: UIScrollView!
    
    private var datePicker: UIDatePicker!
    
    var userData : FetchUser?
    var extraHeight = 0
    var editState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setDatePicker()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        setUpNavBar()
    }
    
    private func setDelegates(){
        tfDOB.delegate = self
        tfEmail.delegate = self
        tfPhone.delegate = self
        tfLastName.delegate = self
        tfFirstName.delegate = self
    }
    
    private func setUpUI(){
        
        //Views
        for v in containerViews{
            v.layer.borderWidth = 1.0
            v.layer.borderColor = UIColor(named: "Primary Foreground")?.cgColor
        }
        
        tfFirstName.text = userData?.data?.user_data?.first_name
        tfLastName.text = userData?.data?.user_data?.last_name
        tfEmail.text = userData?.data?.user_data?.email
        tfPhone.text = userData?.data?.user_data?.phone_no
        tfDOB.text = userData?.data?.user_data?.dob
        
        if let img = userData?.data?.user_data?.profile_pic{
            profileImg.sd_setImage(with: URL(string: img))
        }
        
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
        
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        profileImg.addGestureRecognizer(imgTap)
        
        btnEditProflie.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
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
    func setUpNavBar(){
        
        navigationController?.navigationBar.isHidden = false
        
        
        navigationItem.title = "My Account"
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
    
    func updateDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Set the desired date format
        
        let selectedDate = datePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        tfDOB.text = formattedDate
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc func datePickerValueChanged() {
        updateDate()
    }
    @objc func imgTapped(){
        tfFirstName.resignFirstResponder()
        actionOptions()
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
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.sourceType = .camera
            image.mediaTypes = [kUTTypeImage as String]
            self.present(image,animated: true,completion:nil)
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
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.profileScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20 + CGFloat(extraHeight)
        profileScrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        profileScrollView.contentInset = contentInset
    }
    
    @objc func doneButtonTapped() {
        tfDOB.resignFirstResponder()
    }
    
    @IBAction func btnEditProfileTapped(_ sender: UIButton) {
        editState = !editState
        if editState {
            tfDOB.isEnabled = true
            tfEmail.isEnabled = true
            tfPhone.isEnabled = true
            tfLastName.isEnabled = true
            tfFirstName.isEnabled = true
            btnRestPassword.isHidden = true
            profileImg.isUserInteractionEnabled = true
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
            btnEditProflie.setTitle("EDIT PROFILE", for: .normal)
            //   navigationItem.title = "My Account"
        }
        
        
        
    }
    
    @IBAction func btnResetPasswordTapped(_ sender: UIButton) {
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        
        let data = convertFromUIImageTODict(info)
        if let editingImg =  data[convertInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage{
            print(editingImg)
            self.profileImg.image = editingImg
        }
//        if let editingImage = info[UIImagePickerController.InfoKey(rawValue: convertInfoKey(UIImagePickerController.InfoKey.editedImage))] as? UIImage{
//            print(editingImage)
//            self.profileImg.image = editingImage
//        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func convertFromUIImageTODict(_ input :[UIImagePickerController.InfoKey: Any]) -> [String:Any]{
        return Dictionary(uniqueKeysWithValues: input.map({ key, value in
            (key.rawValue,value)
        }))
    }
    func convertInfoKey(_ input : UIImagePickerController.InfoKey) -> String{
        return input.rawValue
    }
}
