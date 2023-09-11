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
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var furnitureCollectionView: UICollectionView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    //MARK: - Properties
    private var timer: Timer!
    private var noOfImgs: Int = 0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    
    //MARK: - Functions
    private func setUpUI(){
        setUpNavBar()
        
        setSliderScrollView()
    }
    private func setUpNavBar(){
        
        //Navigation bar
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "NeoSTORE"
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(showDrawer))
        // Set the left bar button item
        navigationItem.leftBarButtonItem = menuButton
       
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(showProductList))
        // Set the left bar button item
        navigationItem.rightBarButtonItem = searchButton
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setDelegates(){
        sliderScrollView.delegate = self
        furnitureCollectionView.delegate = self
        furnitureCollectionView.dataSource = self
    }

    private func xibRegister(){
        furnitureCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    private func setSliderScrollView(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)

        
        for i in 0..<sliderImages.count {

            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            
            let imageWidth = UIScreen.main.bounds.width
            imageView.image = UIImage(named: sliderImages[i])
            let xPos = CGFloat (i) * UIScreen.main.bounds.width
            print(xPos)
            imageView.frame = CGRect (x: xPos, y: 0, width: imageWidth, height: sliderScrollView.frame.size.height)
            sliderScrollView.contentSize.width = UIScreen.main.bounds.width*CGFloat(i+1)
            sliderScrollView.showsHorizontalScrollIndicator = false
            sliderScrollView.addSubview(imageView)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        sliderPageControl.numberOfPages = sliderImages.count
        sliderPageControl.currentPage = Int(page)
    }
    
    //MARK: - @objc Functions
    @objc func showDrawer(){
        homeViewDelegate?.showDrawer()
    }
    
    @objc func showProductList(){
        let nextViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func timerRunning() {
        
        noOfImgs = (noOfImgs + 1) % sliderImages.count // Cycle through image indices

            let offsetX = CGFloat(noOfImgs) * UIScreen.main.bounds.width
            sliderScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)

    }
    
    //MARK: - IBActions
    @IBAction func pageChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        sliderScrollView.setContentOffset(CGPoint(x: CGFloat(current) * UIScreen.main.bounds.width, y: 0), animated: true)
    }
    
}

//MARK: - CollectionView Delegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == furnitureCollectionView{
            return 4
        }
        return sliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.setContraints(lblname: furnitureData[indexPath.row]["name"] as! String, lblPosition: furnitureData[indexPath.row]["lblPosition"] as! Positions, imgName: furnitureData[indexPath.row]["imgName"] as! String, imgPosition: furnitureData[indexPath.row]["imgPosition"] as! Positions)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == furnitureCollectionView{
            let nextViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
            nextViewController.productCategoryId = indexPath.row + 1
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width
        let spacing: CGFloat = 50 
        let cellWidth = (availableWidth - spacing) / 2
        return CGSize(width: cellWidth, height: cellWidth)
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
    
}
