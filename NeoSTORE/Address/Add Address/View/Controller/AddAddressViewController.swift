//
//  AddAddressViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class AddAddressViewController: UIViewController {

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
    
    var loaderView: UIView?
    
    let addAddressViewModel = AddAddressViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        setUpNavBar()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        btnSaveAddress.layer.cornerRadius = 5
    }
    private func setUpNavBar(){
        //Navigation bar
        navigationItem.title = "Add Address"
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.addAddressScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        addAddressScrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        addAddressScrollView.contentInset = contentInset
    }
    
    
    @IBAction func btnSaveAddressTapped(_ sender: UIButton) {
        if tvAddress.text == ""{
            self.showAlert(title: "Alert", msg: "Fill Address")
        }
        else {
            let address1 = tvAddress.text + " " + (tfLandmark.text ?? "") + " "
            let address2 = (tfCity.text ?? "") + " " + (tfZipCode.text ?? "") + " "
            let address3 = (tfState.text ?? "") + " " + (tfCountry.text ?? "")
            let address = address1 + address2 + address3
            UserDefaults.standard.set(address, forKey: "userAddress")
            let alert = UIAlertController(title: "Success", message: "Your Address is Saved Successfully", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)

        }
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

extension AddAddressViewController: UITextViewDelegate,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfLandmark{
            tfLandmark.resignFirstResponder()
            tfCity.becomeFirstResponder()
        } else if textField == tfCity{
            tfCity.resignFirstResponder()
            tfState.becomeFirstResponder()
        } else if textField == tfState{
            tfState.resignFirstResponder()
            tfZipCode.becomeFirstResponder()
        } else if textField == tfZipCode{
            tfZipCode.resignFirstResponder()
            tfCountry.becomeFirstResponder()
        } else if textField == tfCountry{
            tfCountry.resignFirstResponder()
        }
        return true
    }
}
