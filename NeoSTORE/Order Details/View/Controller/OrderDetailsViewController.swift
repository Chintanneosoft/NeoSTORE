//
//  OrderDetailsViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var orderDetailsTableView: UITableView!
    
    let orderDetailsViewModel = OrderDetailsViewModel()
    
    var orderId: Int?
    
    var loaderView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callOrderDetails()
    }
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "Order ID: "  + String(describing: (orderId ?? 0))
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
    private func setDelegates(){
        orderDetailsTableView.delegate = self
        orderDetailsTableView.dataSource = self
    }

    private func xibRegister(){
        orderDetailsTableView.register(UINib(nibName: "OrderDetailsCell", bundle: nil), forCellReuseIdentifier: "OrderDetailsCell")
        orderDetailsTableView.register(UINib(nibName: "TotalCell", bundle: nil), forCellReuseIdentifier: "TotalCell")
    }
    
    private func callOrderDetails(){
        orderDetailsViewModel.orderDetailsViewModelDelegate = self
        showLoader()
        orderDetailsViewModel.getOrderDetails(orderId: orderId ?? 0)
    }

}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return orderDetailsViewModel.orderDetails?.data?.orderDetails.count ?? 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = orderDetailsTableView.dequeueReusableCell(withIdentifier: "OrderDetailsCell", for: indexPath) as! OrderDetailsCell
            cell.setDetails(imgURL: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].prodImage ?? "", productName: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].prodName ?? "", productCategory: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].prodCatName ?? "", quantity: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].quantity ?? 0, price: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].total ?? 0)
            cell.selectionStyle = .none
            return cell
        }
        let cell = orderDetailsTableView.dequeueReusableCell(withIdentifier: "TotalCell", for: indexPath) as! TotalCell
        cell.setDetails(totalPrice: orderDetailsViewModel.orderDetails?.data?.cost ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension OrderDetailsViewController: OrderDetailsViewModelDelegate{
    func successOrderDetails() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.orderDetailsTableView.reloadData()
        }
    }
    
    func failureOrderDetails(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.showAlert(title: "Error", msg: msg)
        }
    }
    
    
}
