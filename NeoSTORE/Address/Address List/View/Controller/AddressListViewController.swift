//
//  AddressListViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class AddressListViewController: UIViewController {

    @IBOutlet weak var lblShippingAddress: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var addressListTableView: UITableView!
    
    var addressListViewModel = AddressListViewModel()
    
    var btnSelected: Int?
    
    var loaderView: UIView?
    var address: [String?] = []
    var selectedAddress: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
        setAddress()
        addressListTableView.reloadData()
    }
    
    private func setDelegates(){
        addressListTableView.dataSource = self
        addressListTableView.delegate = self
    }
    
    private func xibRegister(){
        addressListTableView.register(UINib(nibName: "AddressListCell", bundle: nil), forCellReuseIdentifier: "AddressListCell")
    }
    
    private func setAddress(){
        address = []
        address += [UserDefaults.standard.string(forKey: "userAddress")]
        btnSelected = nil
    }
    private func setUpNavBar(){
        //Navigation bar
        navigationItem.title = "Address List"
       
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAddress))
        // Set the left bar button item
        navigationItem.rightBarButtonItem = plusButton
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
    }
    @objc func addAddress(){
        let nextViewController = AddAddressViewController(nibName: "AddAddressViewController", bundle: nil)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func btnPlaceOrder(_ sender: UIButton) {
        if btnSelected != nil{
            addressListViewModel.addressListViewModelDelegate = self
            self.showLoader(view: self.view, aicView: &self.loaderView)
            self.addressListViewModel.placeOrder(address: address[0] ?? "")
        }
        else{
            self.showAlert(title: "Alert", msg: "Select Address")
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
extension AddressListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressListTableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! AddressListCell
        
        let addressWords = address[0]?.components(separatedBy: " ")

            // Check if there are any words in the address
            if let firstWord = addressWords?.first {
                cell.lblTitle.text = firstWord
            } else {
                cell.lblTitle.text = "No Address"
            }

        cell.lblAddress.text = address[0] ?? "Please Add Address"
        
        if btnSelected == indexPath.row{
            cell.btnSelect.isSelected = true
        }
        else{
            cell.btnSelect.isSelected = false
        }
        cell.btnSelect.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnSelected = indexPath.row
        addressListTableView.reloadData()
    }
    
}
extension AddressListViewController: AddressListCellDelegate{
    func btnSelectTapped(btnTag: Int) {
        btnSelected = btnTag
        addressListTableView.reloadData()
    }
}

extension AddressListViewController: AddressListViewModelDelegate{
    func successAddress(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader(viewLoaderScreen: self.loaderView)
            self.showAlert(title: "Success", msg: msg)
        }
    }

    func failureAddress(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader(viewLoaderScreen: self.loaderView)
            self.showAlert(title: "Error", msg: msg)
        }
    }
}

