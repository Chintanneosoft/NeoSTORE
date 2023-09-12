//
//  CartViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit
//MARK: - CartViewController
class CartViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var btnOrderNow: UIButton!
    @IBOutlet weak var quantityPickerView: UIPickerView!
    
    //ViewModel Object
    let cartViewModel = CartViewModel()
    
    //properties
    var quantityArr = ["1","2","3","4","5","6","7"]
    var dropDownState: Bool = false
    var loaderView : UIView?
    var currProductId = 0
    var currQuantity = 0
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callMyCart()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    //MARK: - Functions
    private func setUpUI(){
        btnOrderNow.layer.cornerRadius = 5
        btnOrderNow.titleLabel?.font = UIFont(name: Font.fontBold.rawValue, size: 20)
    }
    
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "My Cart"
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
    
    private func setDelegates(){
        cartTableView.delegate = self
        cartTableView.dataSource = self
        quantityPickerView.delegate = self
        quantityPickerView.dataSource = self
    }
    
    private func xibRegister(){
        cartTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        cartTableView.register(UINib(nibName: "TotalCell", bundle: nil),forCellReuseIdentifier: "TotalCell")
    }
    
    private func callMyCart(){
        cartViewModel.cartViewModelDelegate = self
        self.showLoader()
        cartViewModel.callFetchCart()
    }
    
    //MARK: - IBActions
    @IBAction func btnOrderNowTapped(_ sender: UIButton) {
        let nextViewController = AddressListViewController(nibName: "AddressListViewController", bundle: nil)
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}

//MARK: - TableView Delegate and Datasource
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 1
        }
        return cartViewModel.cartList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
            cell.setDetails(imgUrl: cartViewModel.cartList?[indexPath.row].product.productImages ?? "", productName: cartViewModel.cartList?[indexPath.row].product.name ?? "", productCategory: cartViewModel.cartList?[indexPath.row].product.productCategory ?? "", price: cartViewModel.cartList?[indexPath.row].product.cost ?? 0, quantity: cartViewModel.cartList?[indexPath.row].quantity ?? 0, productID: cartViewModel.cartList?[indexPath.row].productID ?? 0)
            cell.updateQuantityDelegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "TotalCell", for: indexPath) as! TotalCell
        cell.setDetails(totalPrice: cartViewModel.myCart?.total ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 0 {
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
                self.showLoader()
                self.cartViewModel.callDeleteCart(productId: self.cartViewModel.cartList?[indexPath.row].productID ?? 0)
                self.cartViewModel.cartList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }
            
            deleteAction.image = UIImage(named: "delete")
            deleteAction.backgroundColor = .white
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
            
            return swipeConfiguration
        }
        else{
            return nil
        }
    }

}

//MARK: - PickerView Delegate and Datasource
extension CartViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantityArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quantityArr[row] // Replace with data from your data source array
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle row selection if needed
        currQuantity = Int(quantityArr[row]) ?? 0
        changeState()
        self.showLoader()
        cartViewModel.callUpdateCart(productId: currProductId, quantity: currQuantity)
    }
    
}

//MARK: - CartViewModelDelegate
extension CartViewController: CartViewModelDelegate{
    func setCart() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.cartTableView.reloadData()
            if self.cartViewModel.cartList?.count != nil {
                self.btnOrderNow.isEnabled = true
            }
            else {
                self.btnOrderNow.isEnabled = false
            }
        }
    }
    
    func failureCart(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.cartTableView.reloadData()
            self.showAlert(title: "Error", msg: msg)
            
        }
    }
        
}

//MARK: - UpdateQuantity
extension CartViewController: UpdateQuantity{
    
    func changeDropDownState(productId: Int) {
        currProductId = productId
        changeState()
    }
    
    func changeState(){
        if dropDownState{
            quantityPickerView.isHidden = true
            dropDownState = false
        } else {
            quantityPickerView.isHidden = false
            dropDownState = true
        }
    }
}
