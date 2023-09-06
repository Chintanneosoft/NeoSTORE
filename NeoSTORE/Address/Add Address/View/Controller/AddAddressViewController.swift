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
    
    var loaderView: UIView?
    
    let addAddressViewModel = AddAddressViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    private func setUpNavBar(){
        //Navigation bar
        navigationItem.title = "Add Address"
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
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
            let alert = UIAlertController(title: nil, message: "Your Address is Saved Successfully", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)

//            self.addAddressViewModel.addAddressViewModelDelegate = self
//            self.showLoader(view: self.view, aicView: &self.loaderView)
//            self.addAddressViewModel.addAddress(address: address)
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

//extension AddAddressViewController: AddAddressViewModelDelegate{
//    func successAddress(msg: String) {
//        DispatchQueue.main.async {
//            self.hideLoader(viewLoaderScreen: self.loaderView)
//            self.showAlert(title: "Success", msg: msg)
//        }
//    }
//
//    func failureAddress(msg: String) {
//        DispatchQueue.main.async {
//            self.hideLoader(viewLoaderScreen: self.loaderView)
//            self.showAlert(title: "Error", msg: msg)
//        }
//    }
//
//
//}
