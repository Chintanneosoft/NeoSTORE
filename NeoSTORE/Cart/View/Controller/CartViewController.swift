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
    
    let cartViewModel = CartViewModel()
    
    var loaderView : UIView?
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
            cell.setDetails(imgUrl: cartViewModel.cartList?[indexPath.row].product.productImages ?? "", productName: cartViewModel.cartList?[indexPath.row].product.name ?? "", productCategory: cartViewModel.cartList?[indexPath.row].product.productCategory ?? "", price: cartViewModel.cartList?[indexPath.row].product.cost ?? 0)
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
