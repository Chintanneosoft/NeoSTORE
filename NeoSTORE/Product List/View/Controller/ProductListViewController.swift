//
//  ProductListViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit

class ProductListViewController: UIViewController {

    
    @IBOutlet weak var productListTableView: UITableView!
    
    var productsData: Products?
    var productCategoryId: Int?
    var categoryName: String?
    var loaderView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        callViewModelFetchProductList()
        // Do any additional setup after loading the view.
        
    }

    private func setDelegates(){
        productListTableView.delegate = self
        productListTableView.dataSource = self
    }
    private func xibRegister(){
        productListTableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        
    }
    private func setUpUI(){
        
        //Navigation bar
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary Foreground")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "Primary Background")
        
        navigationItem.title = categoryName
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Font.fontBold.rawValue, size: 26)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
        ]
        
    }
    private func callViewModelFetchProductList(){
        self.showLoader(view: self.view, aicView: &self.loaderView)
        let productListViewModel = ProductListViewModel()
        productListViewModel.productListViewModelDelegate = self
        productListViewModel.callFetchProductList(productCategory: productCategoryId ?? 0)
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

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsData?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        cell.setDetails(productImgName: productsData?.data?[indexPath.row].productImages ?? "", productName: productsData?.data?[indexPath.row].name ?? "", producerName: productsData?.data?[indexPath.row].producer ?? "", price: productsData?.data?[indexPath.row].cost ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension ProductListViewController: ProductListViewModelDelegate{
    func setProductsList(productList: Products) {
        self.productsData = productList
        DispatchQueue.main.async {
            self.productListTableView.reloadData()
            self.hideLoader(viewLoaderScreen: self.loaderView)
        }
    }
    func failureProductList() {
        navigationController?.popViewController(animated: true)
    }
}
