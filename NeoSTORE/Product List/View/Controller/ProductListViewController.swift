import UIKit

//MARK: - ProductListViewController
class ProductListViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var productListTableView: UITableView!
    @IBOutlet weak var tfsearch: UITextField!
    @IBOutlet weak var productListStackView: UIStackView!
    
    //properties
    let productListViewModel = ProductListViewModel()
    //    var productsDataCopy: [ProductsData] = []
    //    var productsData: [ProductsData] = []
    var productCategoryId: Int?
    var productImg: UIImage?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setUpNavBar()
        fetchProductList()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return ProductListViewController(nibName: "ProductListViewController", bundle: nil)
    }
    
    private func setDelegates(){
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
        tfsearch.delegate = self
    }
    
    private func xibRegister(){
        productListTableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
    }
    
    private func setUpUI(){
        tfsearch.font = UIFont.customFont(Font.fontRegular, size: 18)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tfsearch.leftView = leftPaddingView
        tfsearch.leftViewMode = .always
        
        mainScrollView = productListTableView
    }
    
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        navigationItem.title = productListViewModel.getTitle(categoryID: productCategoryId ?? 0)
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    //wrong
    //    private func getTitle(categoryID: Int) -> String {
    //        if categoryID == 1 {
    //            return "Tables"
    //        }
    //        else if categoryID == 2 {
    //            return "Chairs"
    //        }
    //        else if categoryID == 3 {
    //            return "Sofas"
    //        }
    //        else {
    //            return "Cupboards"
    //        }
    //    }
    
    private func toogleSearchState(){
        tfsearch.isHidden = !tfsearch.isHidden
        tfsearch.isHidden ? tfsearch.resignFirstResponder() : tfsearch.becomeFirstResponder()
        
        //wrong
        //        if tfsearch.isHidden == true{
        //            tfsearch.isHidden = false
        //            tfsearch.becomeFirstResponder()
        //        }
        //        else{
        //            tfsearch.isHidden = true
        //            tfsearch.text = ""
        //            tfsearch.resignFirstResponder()
        //        }
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
}

//MARK: - TableView Delegate and Datasource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.productsDataCopy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        //wrong
        cell.setDetails(productImgName:productListViewModel.productsDataCopy[indexPath.row].productImages ?? "", productName: productListViewModel.productsDataCopy[indexPath.row].name ?? "", producerName: productListViewModel.productsDataCopy[indexPath.row].producer ?? "", price: productListViewModel.productsDataCopy[indexPath.row].cost ?? 0,rating: productListViewModel.productsDataCopy[indexPath.row].rating ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = ProductDetailsViewController.loadFromNib() as! ProductDetailsViewController
        nextViewController.productId = productListViewModel.productsDataCopy[indexPath.row].id
        nextViewController.productCategory = productListViewModel.getTitle(categoryID: productCategoryId ?? 0)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

//MARK: - ProductListViewModelDelegate
extension ProductListViewController: ProductListViewModelDelegate{
    func setProductsList() {
        DispatchQueue.main.async {
            self.productListViewModel.productsDataCopy = self.productListViewModel.productsData?.data ?? []
            self.productListTableView.reloadData()
            self.hideLoader()
        }
    }
    func failureProductList(msg: String) {
        print(msg)
        DispatchQueue.main.async {
            self.showSingleButtonAlert(title: "Error", msg: msg, okClosure: nil)
        }
    }
}

//MARK: - TextField Delegate
extension ProductListViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if newText.isEmpty{
            productListViewModel.productsDataCopy = productListViewModel.productsData?.data ?? []
        } else {
            productListViewModel.productsDataCopy = productListViewModel.productsData?.data?.filter{$0.name?.lowercased().contains(newText.lowercased()) ?? false} ?? []
        }
        productListTableView.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        toogleSearchState()
        return false
    }
}
