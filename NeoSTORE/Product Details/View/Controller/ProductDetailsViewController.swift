//
//  ProductDetailsViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productsDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        // Do any additional setup after loading the view.
    }
    private func setDelegates(){
        productsDetailsTableView.delegate = self
        productsDetailsTableView.dataSource = self
    }
    private func xibRegister(){
        productsDetailsTableView.register(UINib(nibName: "ProductsNameCell", bundle: nil), forCellReuseIdentifier: "ProductsNameCell")
        productsDetailsTableView.register(UINib(nibName: "ProductsDetailCell", bundle: nil), forCellReuseIdentifier: "ProductsDetailCell")
        productsDetailsTableView.register(UINib(nibName: "ProductBottomCell", bundle: nil), forCellReuseIdentifier: "ProductBottomCell")
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

extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsNameCell", for: indexPath) as! ProductsNameCell
            cell.setDetails(imgName: "", productName: "Product Name", producerName: "Producer", price: 0)
            return cell
        case 1:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsDetailCell", for: indexPath) as! ProductsDetailCell
            cell.setDetails(imgName: "", price: 0)
            return cell
        case 2:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductBottomCell", for: indexPath) as! ProductBottomCell
            return cell
        default:
            print("")
        }
        let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsNameCell", for: indexPath)
        return cell
    }
    
    
}
