//
//  CartViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var btnOrderNow: UIButton!
    
    @IBOutlet weak var quantityPickerView: UIPickerView!
    var quantityArr = ["1","2","3","4","5","6","7"]
    
    let cartViewModel = CartViewModel()
    
    var dropDownState: Bool = false
    var loaderView : UIView?
    
    var currProductId = 0
    var currQuantity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callMyCart()
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setUpNavBar() {
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
        self.showLoader(view: view, aicView: &self.loaderView)
        cartViewModel.callFetchCart()
    }
    
    @IBAction func btnOrderNowTapped(_ sender: UIButton) {
        let nextViewController = AddressListViewController(nibName: "AddressListViewController", bundle: nil)
        navigationController?.pushViewController(nextViewController, animated: true)
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

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete && indexPath.section == 0 {
//            // Handle the delete action for "cartList" items
//            cartViewModel.cartList?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            // Update your total calculation if necessary
//        }
//
//    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 0 {
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
                self.showLoader(view: self.view, aicView: &self.loaderView)
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
        self.showLoader(view: self.view, aicView: &self.loaderView)
        cartViewModel.callUpdateCart(productId: currProductId, quantity: currQuantity)
    }
    
}

extension CartViewController: CartViewModelDelegate{
    func setCart() {
        DispatchQueue.main.async {
            self.hideLoader(viewLoaderScreen: self.loaderView)
            self.cartTableView.reloadData()
        }
    }
    
    func failureCart(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader(viewLoaderScreen: self.loaderView)
            self.showAlert(title: "Error", msg: msg)
        }
    }
        
}

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
