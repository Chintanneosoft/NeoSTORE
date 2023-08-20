//
//  DrawerViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

//MARK: - DrawerViewController
class DrawerViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var drawerTableView: UITableView?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    private func setDelegates(){
        drawerTableView?.delegate = self
        drawerTableView?.dataSource = self
    }
    
    private func xibRegister(){
        drawerTableView?.registerCell(of: HeaderCell.self)
        drawerTableView?.registerCell(of: OptionsCell.self)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.getCell(identifier: "HeaderCell") as HeaderCell
            cell.setDetails(imgName: "user_male", name: "Chintan", email: "Chintan.rajgor@neosoftmail.com")
            return cell
        }
        else {
            let cell = tableView.getCell(identifier: "OptionsCell") as OptionsCell
            return cell
        }
    }
    
}

