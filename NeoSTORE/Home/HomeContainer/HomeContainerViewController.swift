//
//  HomeContainerViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit

//MARK: - HomeContainerViewController
class HomeContainerViewController: UIViewController {

    //MARK: - Properties
    enum DrawerState{
        case opened
        case closed
    }

    private var drawerState: DrawerState = .closed
    let drawerVC = DrawerViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChildVCs()
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        navVC?.navigationBar.isHidden = false
    }
    
    //MARK: - Functions
    private func addChildVCs() {
        //Drawer
        
        let viewWidth: CGFloat =  self.view.frame.size.width - 80
        let viewHeight: CGFloat =  self.view.frame.size.height
        self.drawerVC.view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        addChild(drawerVC)
        view.addSubview(drawerVC.view)
        drawerVC.didMove(toParent: self)
        
        //Home
        homeVC.homeViewDelegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
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

//MARK: - HomeContainerViewController Delegate
extension HomeContainerViewController: HomeViewControllerDelegate{
    func showDrawer() {
        // Shows Drawer
        switch drawerState{
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut){
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 80
             
            } completion: { [weak self] done in
                if done{
                    self?.drawerState = .opened
                }
            }
        case .opened:
            // close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut){
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done{
                    self?.drawerState = .closed
                }
            }
        }
    }
}
