import UIKit
//MARK: - CartViewController
class CartViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var btnOrderNow: UIButton!
    @IBOutlet weak var lblEmptyCart: UILabel!
    //wrong
    let quantityPickerView = UIPickerView()
        
    //ViewModel Object
    let cartViewModel = CartViewModel()
    
    //properties
    //wrong
    var currProductId = 0
    var currQuantity = 0
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callMyCart()
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return CartViewController(nibName: "CartViewController", bundle: nil)
    }
    
    private func setUpUI(){
        btnOrderNow.layer.cornerRadius = 5
        btnOrderNow.titleLabel?.font = UIFont.customFont(Font.fontBold, size: 20)
        mainScrollView = cartTableView
    }
    
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "My Cart"
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
        let nextViewController = AddressListViewController.loadFromNib() as! AddressListViewController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

//MARK: - TableView Delegate and Datasource
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartViewModel.cartList?.count ?? 0 == 0{
            lblEmptyCart.isHidden = false
            return 0
        }
        lblEmptyCart.isHidden = true
        return (cartViewModel.cartList?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < cartViewModel.cartList?.count ?? 0{
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
            cell.setDetails(imgUrl: cartViewModel.cartList?[indexPath.row].product.productImages ?? "", productName: cartViewModel.cartList?[indexPath.row].product.name ?? "", productCategory: cartViewModel.cartList?[indexPath.row].product.productCategory ?? "", price: cartViewModel.cartList?[indexPath.row].product.cost ?? 0, quantity: cartViewModel.cartList?[indexPath.row].quantity ?? 0, productID: cartViewModel.cartList?[indexPath.row].productID ?? 0)
            cell.updateQuantityDelegate = self
            cell.txtQuantity.inputView = quantityPickerView
            quantityPickerView.selectRow(cartViewModel.quantityArr.firstIndex(of: String(cartViewModel.cartList?[indexPath.row].quantity ?? 1)) ?? 0, inComponent: 0, animated: true)
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
                
                self.showDualButtonAlert(title: "Alert", msg: "Do you want to delete the row", okClosure: {
                    self.showLoader()
                    self.cartViewModel.callDeleteCart(productId: self.cartViewModel.cartList?[indexPath.row].productID ?? 0)
                    self.cartViewModel.cartList?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    NotificationCenter.default.post(name: .updateDrawer, object: nil)
                }, cancelClosure: {
                    self.dismiss(animated: true)
                })
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
        return cartViewModel.quantityArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //wrong: next time se seedha vc delete
        return cartViewModel.quantityArr[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currQuantity = Int(cartViewModel.quantityArr[row]) ?? 0
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
            self.btnOrderNow.isEnabled = (self.cartViewModel.cartList?.count != nil)
        }
    }
    
    func failureCart(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.cartTableView.reloadData()
            if msg == "Cart empty."{
                self.showSingleButtonAlert(title: "Error", msg: msg, okClosure: nil)
            }
        }
    }
}

//MARK: - UpdateQuantity
extension CartViewController: UpdateQuantity{
    func changeDropDownState(productId: Int, quantity: String) {
        currProductId = productId
        quantityPickerView.selectRow((Int(quantity) ?? 2)-1, inComponent: 0, animated: true)
    }
}
