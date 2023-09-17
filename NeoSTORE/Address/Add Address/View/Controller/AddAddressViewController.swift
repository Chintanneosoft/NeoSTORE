//
//  AddAddressViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class AddAddressViewController: BaseViewController {

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
    
    
    let addAddressViewModel = AddAddressViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        addObservers()
        setTapGestures()
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
        mainScrollView = addAddressScrollView
        
        btnSaveAddress.layer.cornerRadius = 5
        btnSaveAddress.titleLabel?.font = UIFont(name: Font.fontBold.rawValue, size: 20)
    }
    
    private func setUpNavBar(){
        //Navigation bar
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "Add Address"
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
    }
       
    
    @IBAction func btnSaveAddressTapped(_ sender: UIButton) {
        if tvAddress.text == "" || tfLandmark.text == "" || tfCity.text == "" || tfState.text == "" || tfCountry.text == "" || tfZipCode.text == ""{
            self.showSingleButtonAlert(title: "Alert", msg: "Fill all the Fields", okClosure: nil)
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
