//
//  ProductListViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit

//MARK: - ProductListViewController
class ProductListViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var productListTableView: UITableView!
    @IBOutlet weak var productsViewed: UILabel!
    @IBOutlet weak var tfsearch: UITextField!
    @IBOutlet weak var productListStackView: UIStackView!
    
    //properties
    let productListViewModel = ProductListViewModel()
    var numberOfProductsViewed: Int = 0
    var productsDataCopy: [ProductsData] = []
    var productsData: [ProductsData] = []
    var productCategoryId: Int?
    var productImg: UIImage?
    var tapGesture: (Any)? = nil
    
    //MARK: - ViewDidLoad
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
        fetchProductList()
    }
    
    //MARK: - Functions
    private func setDelegates(){
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
        tfsearch.delegate = self
    }
    
    private func xibRegister(){
        productListTableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        
    }
    
    private func setUpUI(){
        
        tfsearch.font = UIFont(name: Font.fontRegular.rawValue, size: 18)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tfsearch.leftView = leftPaddingView
        tfsearch.leftViewMode = .always
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        navigationItem.title = getTitle(categoryID: productCategoryId ?? 0)
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    //wrong
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
    
    private func toogleSearchState(){
        
//        tfsearch.isHidden = !tfsearch.isHidden
        
        //wrong
        if tfsearch.isHidden == true{
            tfsearch.isHidden = false
            tfsearch.becomeFirstResponder()
        }
        else{
            tfsearch.isHidden = true
            tfsearch.text = ""
            tfsearch.resignFirstResponder()
        }
    }
    
    //MARK: - FetchProductList
    private func fetchProductList(){
        self.showLoader()
        productListViewModel.productListViewModelDelegate = self
        productListViewModel.callFetchProductList(productCategory: productCategoryId ?? 0)
    }
    
    //MARK: - @objc Functions
    @objc func searchIconTapped(){
        toogleSearchState()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        self.view.addGestureRecognizer(self.tapGesture as! UITapGestureRecognizer)
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.productListTableView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        productListTableView.contentInset = contentInset
        
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        self.view.removeGestureRecognizer(self.tapGesture as! UITapGestureRecognizer)
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        productListTableView.contentInset = contentInset
    }
}

//MARK: - TableView Delegate and Datasource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsDataCopy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        //wrong
        cell.setDetails(productImgName:productsDataCopy[indexPath.row].productImages ?? "", productName: productsDataCopy[indexPath.row].name ?? "", producerName: productsDataCopy[indexPath.row].producer ?? "", price: productsDataCopy[indexPath.row].cost ?? 0,rating: productsDataCopy[indexPath.row].rating ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        nextViewController.productId = productsDataCopy[indexPath.row].id
        nextViewController.productCategory = getTitle(categoryID: productCategoryId ?? 0)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

//MARK: - ProductListViewModelDelegate
extension ProductListViewController: ProductListViewModelDelegate{
    
    func setProductsList() {
        DispatchQueue.main.async {
            self.productsData = self.productListViewModel.productsData?.data ?? []
            self.productsDataCopy = self.productsData
            self.productListTableView.reloadData()
            self.hideLoader()
        }
    }
    
    func failureProductList(msg: String) {
        print(msg)
        DispatchQueue.main.async {
            self.showAlert(title: "Error", msg: msg)
        }
    }
}

//MARK: - TextField Delegate
extension ProductListViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        productsDataCopy = productsData
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if newText.isEmpty{
            print(newText)
            productsDataCopy = productsData
            print(productsData.count,productsDataCopy.count)
        } else {
            print(newText)
            productsDataCopy = productsData.filter{$0.name?.lowercased().contains(newText.lowercased()) ?? false}
        }
        print(productsDataCopy.count)
        productListTableView.reloadData()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        toogleSearchState()
        return false
    }
}
