import UIKit

//MARK: - MyOrdersViewController
class MyOrdersViewController: UIViewController {
    
    @IBOutlet weak var myOrdersTableView: UITableView!
    
    let myOrderViewModel = MyOrderViewModel()
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callMyOrderList()
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return MyOrdersViewController(nibName: ViewControllerString.MyOrder.rawValue, bundle: nil)
    }
    
    private func setDelegates(){
        myOrdersTableView.delegate = self
        myOrdersTableView.dataSource = self
    }
    
    private func xibRegister(){
        myOrdersTableView.register(UINib(nibName: Cells.MyOrderCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.MyOrderCell.rawValue)
    }
    
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = ScreenText.MyOrders.navTitle.rawValue
    }
    
    private func callMyOrderList(){
        myOrderViewModel.myOrderViewModelDelegate = self
        showLoader()
        myOrderViewModel.placeOrder()
    }
}

//MARK: - TableView Delegate and Datasource
extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderViewModel.orderList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myOrdersTableView.dequeueReusableCell(withIdentifier: Cells.MyOrderCell.rawValue, for: indexPath) as! MyOrderCell
        cell.setDetails(orderId: myOrderViewModel.orderList?.data[indexPath.row].id ?? 0, orderDate: myOrderViewModel.orderList?.data[indexPath.row].created ?? "", orderPrice: myOrderViewModel.orderList?.data[indexPath.row].cost ?? 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = OrderDetailsViewController.loadFromNib() as! OrderDetailsViewController
        nextViewController.orderId = myOrderViewModel.orderList?.data[indexPath.row].id
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

//MARK: - MyOrderViewModelDelegate
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
            self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
        }
    } 
}
