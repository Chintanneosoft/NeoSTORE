//
//  MyOrdersViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

import UIKit

class MyOrdersViewController: UIViewController {

    @IBOutlet weak var myOrdersTableView: UITableView!
    
    let myOrderViewModel = MyOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callMyOrderList()
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setDelegates(){
        myOrdersTableView.delegate = self
        myOrdersTableView.dataSource = self
    }
    
    private func xibRegister(){
        myOrdersTableView.register(UINib(nibName: "MyOrderCell", bundle: nil), forCellReuseIdentifier: "MyOrderCell")
    }
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "My Orders"
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
    }
    private func callMyOrderList(){
        myOrderViewModel.myOrderViewModelDelegate = self
        showLoader()
        myOrderViewModel.placeOrder()
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

extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderViewModel.orderList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myOrdersTableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath) as! MyOrderCell
        cell.setDetails(orderId: myOrderViewModel.orderList?.data[indexPath.row].id ?? 0, orderDate: myOrderViewModel.orderList?.data[indexPath.row].created ?? "", orderPrice: myOrderViewModel.orderList?.data[indexPath.row].cost ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = OrderDetailsViewController(nibName: "OrderDetailsViewController", bundle: nil)
        nextViewController.orderId = myOrderViewModel.orderList?.data[indexPath.row].id
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension MyOrdersViewController: MyOrderViewModelDelegate{
    func successOrderList() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.myOrdersTableView.reloadData()
        }
    }
    
    func failureOrderList(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.showSingleButtonAlert(title: "Error", msg: msg, okClosure: nil)
        }
    } 
}
