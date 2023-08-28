//
//  ProductDetailsViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit
//MARK: - ProductDetailsViewController
class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productsDetailsTableView: UITableView!
    private var productsDetails: ProductDetails?
    var productId : Int?
    var productCategory : String?
    var loaderView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        callViewModelFetchProductDetails()
        // Do any additional setup after loading the view.
    }
    private func setDelegates(){
        productsDetailsTableView.delegate = self
        productsDetailsTableView.dataSource = self
    }
    private func xibRegister(){
        productsDetailsTableView.register(UINib(nibName: "ProductsNameCell", bundle: nil), forCellReuseIdentifier: "ProductsNameCell")
        productsDetailsTableView.register(UINib(nibName: "ProductsDetailCell", bundle: nil), forCellReuseIdentifier: "ProductsDetailCell")
        productsDetailsTableView.register(UINib(nibName: "ProductBottomCell", bundle: nil), forCellReuseIdentifier: "ProductBottomCell")
    }
    private func callViewModelFetchProductDetails(){
        self.showLoader(view: self.view, aicView: &self.loaderView)
        let productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.productDetailsViewModelDelegate = self
        productDetailsViewModel.callProductDetails(productId: productId ?? 0)
    }
}

//MARK: - TableView Delegate and DataSource
extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsNameCell", for: indexPath) as! ProductsNameCell
            cell.setDetails(productName: productsDetails?.data?.name ?? "", producerName: productsDetails?.data?.producer ?? "", category: productCategory ?? "")
            return cell
        case 1:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsDetailCell", for: indexPath) as! ProductsDetailCell
            cell.setDetails(productImages: productsDetails?.data?.productImages ?? [], productDescription: productsDetails?.data?.dataDescription ?? "", price: productsDetails?.data?.cost ?? 0)
            return cell
        case 2:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductBottomCell", for: indexPath) as! ProductBottomCell
            return cell
        default:
            print("")
        }
        let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsNameCell", for: indexPath)
        return cell
    }
    
}

//MARK: - ProductDetailsViewModelDelegate
extension ProductDetailsViewController: ProductDetailsViewModelDelegate{
    func setProductDetails(productDetails: ProductDetails) {
        self.productsDetails = productDetails
        DispatchQueue.main.async {
            self.productsDetailsTableView.reloadData()
            self.hideLoader(viewLoaderScreen: self.loaderView)
        }
    }
    
    func failureProductDetails(msg: String) {
        print(msg)
        showAlert(title: "Error", msg: msg)
    }
    
    
}
