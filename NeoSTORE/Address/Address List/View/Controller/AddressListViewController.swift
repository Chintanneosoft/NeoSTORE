import UIKit
//MARK: - AddressListViewController
class AddressListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblShippingAddress: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var addressListTableView: UITableView!
    
    //ViewModel Object
    var addressListViewModel = AddressListViewModel()
    
    //properties
    var selectedIndex: Int?
    
   //wrong
    var address: [String?] = []
    var selectedAddress: String?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
        setAddress()
        addressListTableView.reloadData()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return AddressListViewController(nibName: "AddressListViewController", bundle: nil)
    }
    
    private func setDelegates(){
        addressListTableView.dataSource = self
        addressListTableView.delegate = self
    }
    
    private func xibRegister(){
        addressListTableView.register(UINib(nibName: "AddressListCell", bundle: nil), forCellReuseIdentifier: "AddressListCell")
    }
    
    private func setAddress(){
        address = []
        address += [UserDefaults.standard.string(forKey: "userAddress")]
        selectedIndex = nil
    }
    
    private func setUpNavBar(){
        //Navigation bar
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "Address List"
       
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAddress))
        // Set the left bar button item
        navigationItem.rightBarButtonItem = plusButton
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        
        lblShippingAddress.font = UIFont.customFont(Font.fontThin, size: 18)
        btnPlaceOrder.layer.cornerRadius = 5
        btnPlaceOrder.titleLabel?.font = UIFont.customFont(Font.fontBold, size: 20)
    }
    
    //MARK: - @objc Funtions
    @objc func addAddress(){
        let nextViewController = AddAddressViewController.loadFromNib()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //MARK: - IBActions
    @IBAction func btnPlaceOrder(_ sender: UIButton) {
        if selectedIndex != nil{
            addressListViewModel.addressListViewModelDelegate = self
            self.showLoader()
            if address.count > 0{
                self.addressListViewModel.placeOrder(address: address[0] ?? "")
            }
        }
        else{
            self.showSingleButtonAlert(title: "Alert", msg: "Select Address", okClosure: nil)
        }
    }

}

//MARK: - TableView Delegate and Datasource
extension AddressListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addressListTableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! AddressListCell
        cell.addressListCellDelegate = self

        cell.lblTitle.text = UserDefaults.standard.string(forKey: "userFirstName")
        cell.lblAddress.text = address[0] ?? "Please Add Address"
        
        //wrong
//        if selectedIndex == indexPath.row{
//            cell.btnSelect.isSelected = true
//        }
//        else{
//            cell.btnSelect.isSelected = false
//        }
        cell.btnSelect.isSelected = (selectedIndex == indexPath.row)
        cell.btnSelect.tag = indexPath.row
        cell.btnCancel.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        addressListTableView.reloadData()
    }
    
}

//MARK: - AddressListCellDelegate
extension AddressListViewController: AddressListCellDelegate{
    
    func btnCancelTapped(btnTag: Int) {
        
        self.showDualButtonAlert(title: "Alert", msg: "Do you want to delete the row", okClosure: {
            let indexPath = IndexPath(row: btnTag, section: 0)
            self.address.remove(at: indexPath.row)
            self.addressListTableView.deleteRows(at: [indexPath], with: .fade)
        }, cancelClosure: {
            self.dismiss(animated: true)
        })
    }
    
    func btnSelectTapped(btnTag: Int) {
        
        //wrong validation
        selectedIndex = btnTag
        addressListTableView.reloadData()
    }
}

//MARK: - AddressListViewModelDelegate
extension AddressListViewController: AddressListViewModelDelegate{
    
    func successAddress(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            NotificationCenter.default.post(name: .updateDrawer, object: nil)
            self.showSingleButtonAlert(title: "Success", msg: msg) {
                if let navigationController = self.navigationController {
                    for viewController in navigationController.viewControllers {
                        if viewController is HomeContainerViewController {
                            navigationController.popToViewController(viewController, animated: true)
                            break
                        }
                    }
                }
            }
        }
    }

    func failureAddress(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.showSingleButtonAlert(title: "Error", msg: msg, okClosure: nil)
        }
    }
}

