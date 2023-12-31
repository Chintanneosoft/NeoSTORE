import UIKit

//MARK: - OrderDetailsViewController
class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var orderDetailsTableView: UITableView!
    
    let orderDetailsViewModel = OrderDetailsViewModel()
    
    var orderId: Int?
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callOrderDetails()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return OrderDetailsViewController(nibName: ViewControllerString.OrderDetails.rawValue, bundle: nil)
    }
    
    private func setUpNavBar() {
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = ScreenText.MyOrders.orderID.rawValue  + String(describing: (orderId ?? 0))
    }
    
    private func setDelegates(){
        orderDetailsTableView.delegate = self
        orderDetailsTableView.dataSource = self
    }

    private func xibRegister(){
        orderDetailsTableView.register(UINib(nibName: Cells.OrderDetailsCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.OrderDetailsCell.rawValue)
        orderDetailsTableView.register(UINib(nibName: Cells.TotalCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.TotalCell.rawValue)
    }
    
    private func callOrderDetails(){
        orderDetailsViewModel.orderDetailsViewModelDelegate = self
        showLoader()
        orderDetailsViewModel.getOrderDetails(orderId: orderId ?? 0)
    }
}

//MARK: - Tableview Delegate and Datasource
extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? orderDetailsViewModel.orderDetails?.data?.orderDetails.count ?? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = orderDetailsTableView.dequeueReusableCell(withIdentifier: Cells.OrderDetailsCell.rawValue, for: indexPath) as! OrderDetailsCell
            cell.setDetails(imgURL: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].prodImage ?? "", productName: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].prodName ?? "", productCategory: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].prodCatName ?? "", quantity: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].quantity ?? 0, price: orderDetailsViewModel.orderDetails?.data?.orderDetails[indexPath.row].total ?? 0)
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = orderDetailsTableView.dequeueReusableCell(withIdentifier: Cells.TotalCell.rawValue, for: indexPath) as! TotalCell
        cell.setDetails(totalPrice: orderDetailsViewModel.orderDetails?.data?.cost ?? 0)
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - OrderDetailsViewModelDelegate
extension OrderDetailsViewController: OrderDetailsViewModelDelegate{
    func successOrderDetails() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.orderDetailsTableView.reloadData()
        }
    }
    
    func failureOrderDetails(msg: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
        }
    }
}
