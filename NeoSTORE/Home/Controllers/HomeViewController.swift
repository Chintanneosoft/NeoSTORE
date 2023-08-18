//
//  HomeViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 17/08/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    var sliderImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setDelegates()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    func setUpUI(){
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary Foreground")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "Primary Background")
        navigationItem.title = "NeoSTORE"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Font.fontRegular.rawValue, size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
              ]
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(showDrawer))
                
                // Set the left bar button item
        navigationItem.leftBarButtonItem = menuButton
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(showDrawer))
                
                // Set the left bar button item
        navigationItem.rightBarButtonItem = searchButton

    }
    func xibRegister(){
        sliderCollectionView.registerCell(of: SliderCollectionViewCell.self)
    }
    func setDelegates(){
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }
    
    @objc func showDrawer(){
        
    }
    @IBAction func pageChange(_ sender: UIPageControl) {
        sliderCollectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .right, animated: true)
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(indexPath: indexPath) as SliderCollectionViewCell
        cell.setImg(imgName: sliderImages[indexPath.row])
        cell.sliderImg?.image = UIImage(named: "\(sliderImages[indexPath.row])")
        return cell
    }
    
}
