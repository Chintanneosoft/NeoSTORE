//
//  ProductListViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit

class ProductListViewController: UIViewController {

    
    @IBOutlet weak var productListTableView: UITableView!
    
    var categoryId = 1
    var categoryName: String {
        switch categoryId{
        case 1:
            return "Table"
        case 2:
            return "Sofas"
        case 3:
            return "Chairs"
        case 4:
            return "Cupboards"
        default:
            return "None"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        cell.setDetails(productImgName: "username_icon", productName: "Table", categoryName: "Table", price: 9374)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
