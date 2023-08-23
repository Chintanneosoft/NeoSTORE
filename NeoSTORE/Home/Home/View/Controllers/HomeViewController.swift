//
//  HomeViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 17/08/23.
//

import UIKit

//MARK: - HomeViewControllerDelegate Protocol
protocol HomeViewControllerDelegate:AnyObject{
    func showDrawer()
}

//MARK: - HomeViewController
class HomeViewController: UIViewController {

    //MARK: - HomeViewControllerDelegate
    weak var homeViewDelegate: HomeViewControllerDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var furnitureCollectionView: UICollectionView!
    @IBOutlet weak var sliderImg: UIImageView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    @IBOutlet var labels: [UILabel]!
    
    //MARK: - Properties
    
    private var sliderImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    private var drawerViewController: DrawerViewController!
    private var furnitureData:[[String:Any]] = [["name":"Table","lblPosition":Positions.topRight,"imgName":"table","imgPosition":Positions.bottomLeft], ["name":"Sofas","lblPosition":Positions.bottomLeft,"imgName":"sofa","imgPosition":Positions.topRight],["name":"Chairs","lblPosition":Positions.topLeft,"imgName":"chair","imgPosition":Positions.bottomRight],["name":"Cupboards","lblPosition":Positions.bottomRight,"imgName":"cupboard","imgPosition":Positions.topLeft]]
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setDelegates()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    private func setUpUI(){
        
        //Navigation bar
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary Foreground")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "Primary Background")
        navigationItem.title = "NeoSTORE"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Font.fontBold.rawValue, size: 26)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
              ]

        let menuButton = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(showDrawer))
                // Set the left bar button item
        navigationItem.leftBarButtonItem = menuButton

        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(showProductList))
                // Set the left bar button item
        navigationItem.rightBarButtonItem = searchButton

        //Labels
        for lbl in labels{
            lbl.font = UIFont(name: Font.fontRegular.rawValue, size: 23)
        }
    }
    
    private func xibRegister(){
//        sliderCollectionView.registerCell(of: SliderCollectionViewCell.self)
        furnitureCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    private func setDelegates(){
//        sliderCollectionView.delegate = self
//        sliderCollectionView.dataSource = self
        furnitureCollectionView.delegate = self
        furnitureCollectionView.dataSource = self
    }
    
    //MARK: - @objc Functions
    @objc func showDrawer(){
        homeViewDelegate?.showDrawer()
        
    }
    @objc func showProductList(){
        let nextViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //MARK: - IBActions
    @IBAction func pageChange(_ sender: UIPageControl) {
//        sliderCollectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .right, animated: true)
        if sender.currentPage + 1 == sliderImages.count{
            sliderImg.image = UIImage(named: sliderImages[0])
        }
        else{
            sliderImg.image = UIImage(named: sliderImages[sender.currentPage+1])
        }
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

//MARK: - CollectionView Delegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sliderImages.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.getCell(indexPath: indexPath) as SliderCollectionViewCell
//        //cell.setImg(imgName: sliderImages[indexPath.row])
//        cell.sliderImg?.image = UIImage(named: "\(sliderImages[indexPath.row])")
//        return cell
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == furnitureCollectionView{
            return 4
        }
        return sliderImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == furnitureCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            cell.setContraints(lblname: furnitureData[indexPath.row]["name"] as! String, lblPosition: furnitureData[indexPath.row]["lblPosition"] as! Positions, imgName: furnitureData[indexPath.row]["imgName"] as! String, imgPosition: furnitureData[indexPath.row]["imgPosition"] as! Positions)
            return cell
            
        }
        
        let cell = collectionView.getCell(indexPath: indexPath) as! SliderCollectionViewCell
                //cell.setImg(imgName: sliderImages[indexPath.row])
        cell.sliderImg?.image = UIImage(named: "\(sliderImages[indexPath.row])")
        return cell
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let availableWidth = collectionView.bounds.width
        let availableHeight = collectionView.bounds.height
            let spacing: CGFloat = 50 // Adjust this value as needed
            let cellWidth = (availableWidth - spacing) / 2
        let cellHeight = (availableHeight - spacing) / 2
            return CGSize(width: cellWidth, height: cellWidth) // Make it square or adjust height as needed
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == furnitureCollectionView{
                let nextViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
                nextViewController.categoryId = indexPath.row + 1
                self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
