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
            let address = tvAddress.text + " " + tfLandmark.text + " " + tfCity.text + " " + tfZipCode.text + " " + tfState.text + " " + tfCountry.text
            self.addAddressViewModel.addAddressViewModelDelegate = self
            self.showLoader(view: self.view, aicView: &self.loaderView)
            self.addAddressViewModel.addAddress(address: address)
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

extension AddAddressViewController: AddAddressViewModelDelegate{
    func successAddress(msg: String) {
        DispatchQueue.main.async {
            hideLoader(viewLoaderScreen: self.loaderView)
            showAlert(title: "Success", msg: msg)
        }
    }
    
    func failureAddress(msg: String) {
        DispatchQueue.main.async {
            showAlert(title: "Error", msg: msg)
        }
    }
    
    
}
