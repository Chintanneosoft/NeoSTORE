import UIKit

//MARK: - DrawerViewControllerDelegate Protocol
protocol DrawerViewControllerDelegate:AnyObject{
    func showDrawer()
}

//MARK: - DrawerViewController
class DrawerViewController: UIViewController {
    
    
    //MARK: - DrawerViewControllerDelegate
    weak var drawerViewControllerDelegate: DrawerViewControllerDelegate?
    
    //MARK: - Properties
    //wrong
    private var optionImgs = ["shoppingcart_icon","table","sofa","chair","cupboard","username_icon","storelocator_icon","myorders_icon","logout_icon"]
    private var optionNames = ["My Cart","Tables","Sofas","Chairs","Cupboards","My Account","Store Locator","My Orders","Logout"]
    
    let drawerViewModel = DrawerViewModel()
   
    private var noOfNotifications: Int?
    //MARK: - IBOutlets
    @IBOutlet weak var drawerTableView: UITableView?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpUI()
        callUserData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .updateCart, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateDrawer, object: nil)
    }
    
    //MARK: - Functions
    private func setUpUI(){
//        callUserData()
        addObservers()
    }
    
    private func addObservers(){
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(updateCartCount(_:)),
                name: .updateCart,
                object: nil
            )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateDrawer),
            name: .updateDrawer,
            object: nil
        )
    }
    private func setDelegates(){
        drawerTableView?.delegate = self
        drawerTableView?.dataSource = self
    }
    
    private func xibRegister(){
        drawerTableView?.register(UINib(nibName: "DrawerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DrawerHeaderTableViewCell")
        drawerTableView?.register(UINib(nibName: "OptionsCell", bundle: nil), forCellReuseIdentifier: "OptionsCell")
    }
    
    private func callUserData(){
        self.showLoader()
        drawerViewModel.drawerViewModelDelegate = self
        drawerViewModel.callFetchUser()
    }
    
    func showDrawer(){
        drawerViewControllerDelegate?.showDrawer()
    }
    
    @objc func updateCartCount(_ notification: Notification){
        noOfNotifications = notification.userInfo?["cartCount"] as? Int
        drawerTableView?.reloadData()
    }
    
    @objc func updateDrawer(_ notification: Notification) {
        callUserData()
    }
    
}

//MARK: - TableView Delegate & DataSource
extension DrawerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return optionImgs.count
        }
    }
    //wrong
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerHeaderTableViewCell") as! DrawerHeaderTableViewCell
            cell.drawerHeaderTableViewCellDelegate = self
            //wrong
            cell.setDetails(imgName: drawerViewModel.userData?.data?.user_data?.profile_pic ?? "", name: ((drawerViewModel.userData?.data?.user_data?.first_name ?? "") + " " + (drawerViewModel.userData?.data?.user_data?.last_name ?? "")), email: drawerViewModel.userData?.data?.user_data?.email ?? "")
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell") as! OptionsCell
            switch indexPath.row{
            case 0:
                cell.setDetails(optionImg: optionImgs[indexPath.row], optionName: optionNames[indexPath.row], noOfNotifications: noOfNotifications ?? 0)
            case 1...4:
                cell.setDetails(optionImg:optionImgs[indexPath.row], optionName:  drawerViewModel.userData?.data?.product_categories?[indexPath.row-1].name ?? "", noOfNotifications: 0)
            case 7:
                cell.setDetails(optionImg: optionImgs[indexPath.row], optionName: optionNames[indexPath.row], noOfNotifications: drawerViewModel.userData?.data?.total_orders ?? 0)
            default:
                cell.setDetails(optionImg: optionImgs[indexPath.row], optionName: optionNames[indexPath.row], noOfNotifications: 0)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 60
        }
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //wrong
        switch indexPath.section{
        case 0:
            drawerViewControllerDelegate?.showDrawer()
            let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            profileViewController.userData = drawerViewModel.userData
            self.navigationController?.pushViewController(profileViewController, animated: true)
        case 1:
            switch indexPath.row{
            case 0:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = CartViewController(nibName: "CartViewController", bundle: nil)
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 1...4:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
                nextViewController.productCategoryId = indexPath.row
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 5:
                drawerViewControllerDelegate?.showDrawer()
                let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
                profileViewController.userData = drawerViewModel.userData
                self.navigationController?.pushViewController(profileViewController, animated: true)
            case 7:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = MyOrdersViewController(nibName: "MyOrdersViewController", bundle: nil)
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 8:
                UserDefaults.standard.set("", forKey: "accessToken")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let windows = windowScene.windows
                    windows.first?.rootViewController = UINavigationController(rootViewController: LoginViewController(nibName: "LoginViewController", bundle: nil))
                    windows.first?.makeKeyAndVisible()
                }
            default:
                print(indexPath.row)
            }
        default:
            print("0")
        }
    }
}

//MARK: - DrawerHeaderTableViewCellDelegate
extension DrawerViewController: DrawerHeaderTableViewCellDelegate{
    func goToProfile() {
        drawerViewControllerDelegate?.showDrawer()
        let nextViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        nextViewController.userData = drawerViewModel.userData
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

//MARK: - DrawerViewModelDelegate
extension DrawerViewController: DrawerViewModelDelegate{
    func setDrawer() {
        DispatchQueue.main.async {
            self.noOfNotifications = self.drawerViewModel.userData?.data?.total_carts
            self.drawerTableView?.reloadData()
            self.hideLoader()
        }
    }
    
    func failureDrawer(msg: String) {
        print(msg)
        DispatchQueue.main.async {
            self.showAlert(title: "Error", msg: msg)
        }
    }
    
}
