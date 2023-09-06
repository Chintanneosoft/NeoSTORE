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
    
    var tapGesture: (Any)? = nil
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        navVC?.navigationBar.isHidden = false
    }
    
    //MARK: - Functions
    private func addChildVCs() {
        //Drawer
        drawerVC.drawerViewControllerDelegate = self
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
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(callDrawer))
       
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
    }
    
    @objc func callDrawer(){
        showDrawer()
    }
}

//MARK: - HomeContainerViewController Delegate
extension HomeContainerViewController: HomeViewControllerDelegate, DrawerViewControllerDelegate{
    func showDrawer() {
        // Shows Drawer
        switch drawerState{
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut){
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 80
                self.homeVC.view.backgroundColor = UIColor(named: "Black Background")
//                self.homeVC.view.isUserInteractionEnabled = false
                self.homeVC.view.addGestureRecognizer(self.tapGesture as! UITapGestureRecognizer)
            } completion: { [weak self] done in
                if done{
                    self?.drawerState = .opened
                }
            }
        case .opened:
            // close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut){
                self.navVC?.view.frame.origin.x = 0
                self.homeVC.view.backgroundColor = UIColor(named: "Primary Background")
//                self.homeVC.view.isUserInteractionEnabled = true
                self.homeVC.view.removeGestureRecognizer(self.tapGesture as! UITapGestureRecognizer)
            } completion: { [weak self] done in
                if done{
                    self?.drawerState = .closed
                }
            }
        }
    }
}
