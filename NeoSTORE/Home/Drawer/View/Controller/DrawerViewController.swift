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
//    private var optionImgs = ["shoppingcart_icon","table","sofa","chair","cupboard","username_icon","storelocator_icon","myorders_icon","logout_icon"]
//    private var optionNames = ["My Cart","Tables","Sofas","Chairs","Cupboards","My Account","Store Locator","My Orders","Logout"]
    
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
    static func loadFromNib() -> UIViewController {
        return DrawerViewController(nibName: ViewControllerString.Drawer.rawValue, bundle: nil)
    }
    
    private func setUpUI(){
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
        drawerTableView?.register(UINib(nibName: Cells.DrawerHeaderTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.DrawerHeaderTableViewCell.rawValue)
        drawerTableView?.register(UINib(nibName: Cells.OptionsCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.OptionsCell.rawValue)
    }
    
    private func callUserData(){
        self.showLoader()
        drawerViewModel.drawerViewModelDelegate = self
        drawerViewModel.callFetchUser()
    }
    
    func showDrawer(){
        drawerViewControllerDelegate?.showDrawer()
    }
    
    //MARK: - @objc
    @objc func updateCartCount(_ notification: Notification){
        noOfNotifications = notification.userInfo?[ScreenText.Drawer.cartCount.rawValue] as? Int
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
        return section == 0 ? 1 : drawerViewModel.drawerOptions.count
    }
    //wrong
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.DrawerHeaderTableViewCell.rawValue) as! DrawerHeaderTableViewCell
            cell.drawerHeaderTableViewCellDelegate = self
            //wrong
            cell.setDetails(imgName: drawerViewModel.userData?.data?.user_data?.profile_pic ?? "", name: ((drawerViewModel.userData?.data?.user_data?.first_name ?? "") + " " + (drawerViewModel.userData?.data?.user_data?.last_name ?? "")), email: drawerViewModel.userData?.data?.user_data?.email ?? "")
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.OptionsCell.rawValue) as! OptionsCell
            switch indexPath.row{
            case 0:
                cell.setDetails(optionImg: drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[1] ?? "", optionName: drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[0] ?? "", noOfNotifications: noOfNotifications ?? 0)
            case 1...4:
                cell.setDetails(optionImg:drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[1] ?? "", optionName:  drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[0] ?? "", noOfNotifications: 0)
            case 7:
                cell.setDetails(optionImg: drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[1] ?? "", optionName: drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[0] ?? "", noOfNotifications: drawerViewModel.userData?.data?.total_orders ?? 0)
            default:
                cell.setDetails(optionImg: drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[1] ?? "", optionName: drawerViewModel.drawerOptions[ScreenText.Drawer.option.rawValue+String(indexPath.row)]?[0] ?? "", noOfNotifications: 0)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 1) ? 60 : 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //wrong
        switch indexPath.section{
        case 0:
            drawerViewControllerDelegate?.showDrawer()
            let profileViewController = ProfileViewController.loadFromNib() as! ProfileViewController
            profileViewController.userData = drawerViewModel.userData
            self.navigationController?.pushViewController(profileViewController, animated: true)
        case 1:
            switch indexPath.row{
            case 0:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = CartViewController.loadFromNib() as! CartViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 1...4:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = ProductListViewController.loadFromNib() as! ProductListViewController
                nextViewController.productCategoryId = indexPath.row
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 5:
                drawerViewControllerDelegate?.showDrawer()
                let profileViewController = ProfileViewController.loadFromNib() as! ProfileViewController
                profileViewController.userData = drawerViewModel.userData
                self.navigationController?.pushViewController(profileViewController, animated: true)
            case 6:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = StoreLocatorViewController.loadFromNib() as! StoreLocatorViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 7:
                drawerViewControllerDelegate?.showDrawer()
                let nextViewController = MyOrdersViewController.loadFromNib() as! MyOrdersViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 8:
                UserDefaults.standard.set("", forKey: UserDefaultsKeys.accessToken.rawValue)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let windows = windowScene.windows
                    windows.first?.rootViewController = UINavigationController(rootViewController: LoginViewController.loadFromNib() as! LoginViewController)
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
        let nextViewController = ProfileViewController.loadFromNib() as! ProfileViewController
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
        DispatchQueue.main.async {
            self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
        }
    }
}
