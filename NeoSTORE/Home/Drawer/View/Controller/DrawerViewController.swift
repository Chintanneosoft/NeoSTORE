//
//  DrawerViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

//MARK: - DrawerViewController
class DrawerViewController: UIViewController {
    
    //MARK: - Properties
    private var optionImgs = ["shoppingcart_icon","table","sofa","chair","cupboard","username_icon","storelocator_icon","myorders_icon","logout_icon"]
    private var optionNames = ["My Cart","Tables","Sofas","Chairs","Cupboards","My Account","Store Locator","My Orders","Logout"]
    private var noOfNotifications = [2,0,0,0,0,0,0,0,0]
    
    //MARK: - IBOutlets
    @IBOutlet weak var drawerTableView: UITableView?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK: - Functions
    private func setDelegates(){
        drawerTableView?.delegate = self
        drawerTableView?.dataSource = self
    }
    
    private func xibRegister(){
        //        drawerTableView?.registerCell(of: HeaderCell.self)
        //        drawerTableView?.registerCell(of: OptionsCell.self)
        
        drawerTableView?.register(UINib(nibName: "DrawerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DrawerHeaderTableViewCell")
        drawerTableView?.register(UINib(nibName: "OptionsCell", bundle: nil), forCellReuseIdentifier: "OptionsCell")
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerHeaderTableViewCell") as! DrawerHeaderTableViewCell
            cell.setDetails(imgName: "username_icon", name: "Chintan", email: "Chintan.rajgor@neosoftmail.com")
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell") as! OptionsCell
            cell.setDetails(optionImg: optionImgs[indexPath.row], optionName: optionNames[indexPath.row], noOfNotifications: noOfNotifications[indexPath.row])
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
        let homeContainerView = HomeContainerViewController()
        switch indexPath.section{
        case 1:
            switch indexPath.row{
            case 0:
                print(0)
            case 1...4:
                
                let nextViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
                nextViewController.productCategoryId = indexPath.row
                homeContainerView.showDrawer()
                homeContainerView.showDrawer()
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case 8:
                UserDefaults.standard.set("", forKey: "accessToken")
               // UserDefaults.standard.set(nil, forKey: "accessToken")
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

