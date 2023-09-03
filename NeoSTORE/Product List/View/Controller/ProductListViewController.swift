//
//  ProductListViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    
    @IBOutlet weak var productListTableView: UITableView!
    
    @IBOutlet weak var productsViewed: UILabel!
    
    
    let productListViewModel = ProductListViewModel()
    var numberOfProductsViewed: Int = 0
    var productsData: Products?
    var productCategoryId: Int?
    var loaderView: UIView?
    var productImg: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpUI()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setUpNavBar()
        callViewModelFetchProductList()
    }
    private func setDelegates(){
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
    }
    private func xibRegister(){
        productListTableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        
    }
    private func setUpUI(){
//        callViewModelFetchProductList()
    }
    private func setUpNavBar() {
        navigationItem.title = getTitle(categoryID: productCategoryId ?? 0)
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
    private func getTitle(categoryID: Int) -> String {
        if categoryID == 1 {
            return "Tables"
        }
        else if categoryID == 2 {
            return "Chairs"
        }
        else if categoryID == 3 {
            return "Sofas"
        }
        else {
            return "Cupboards"
        }
    }
    private func callViewModelFetchProductList(){
        self.showLoader(view: self.view, aicView: &self.loaderView)
        productListViewModel.productListViewModelDelegate = self
        productListViewModel.callFetchProductList(productCategory: productCategoryId ?? 0)
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.productsData?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        cell.setDetails(productImgName: productListViewModel.productsData?.data?[indexPath.row].productImages ?? "", productName: productListViewModel.productsData?.data?[indexPath.row].name ?? "", producerName: productListViewModel.productsData?.data?[indexPath.row].producer ?? "", price: productListViewModel.productsData?.data?[indexPath.row].cost ?? 0,rating: productListViewModel.productsData?.data?[indexPath.row].rating ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        numberOfProductsViewed += 1
//        productsViewed.text = "\(indexPath.row+1) of \(productsData?.data?.count ?? 0)"
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        nextViewController.productId = productListViewModel.productsData?.data?[indexPath.row].id
        nextViewController.productCategory = getTitle(categoryID: productCategoryId ?? 0)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension ProductListViewController: ProductListViewModelDelegate{
    func setProductsList() {
        DispatchQueue.main.async {
            self.productListTableView.reloadData()
            self.hideLoader(viewLoaderScreen: self.loaderView)
        }
    }
    func failureProductList(msg: String) {
        print(msg)
        showAlert(title: "Error", msg: msg)
    }

}
