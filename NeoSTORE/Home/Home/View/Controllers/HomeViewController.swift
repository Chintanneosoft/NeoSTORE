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
    @IBOutlet weak var furnitureCollectionView: UICollectionView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    //MARK: - Properties
    private var timer: Timer!
    private var currImg: Int = 0
    //wrong
//    private var sliderImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    
    private var drawerViewController: DrawerViewController!
    var homeViewModel = HomeViewModel()
    
    //wrong
//    private var furnitureData:[[String:Any]] = [["name":"Table","lblPosition":Positions.topRight,"imgName":"table","imgPosition":Positions.bottomLeft], ["name":"Sofas","lblPosition":Positions.bottomLeft,"imgName":"sofa","imgPosition":Positions.topRight],["name":"Chairs","lblPosition":Positions.topLeft,"imgName":"chair","imgPosition":Positions.bottomRight],["name":"Cupboards","lblPosition":Positions.bottomRight,"imgName":"cupboard","imgPosition":Positions.topLeft]]
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setDelegates()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        self.timer.invalidate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return HomeViewController(nibName: "HomeViewController", bundle: nil)
    }
    
    private func setUpUI(){
        setUpNavBar()
        setSliderScrollView()
    }
    private func setUpNavBar(){
        
        //Navigation bar
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = "NeoSTORE"
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(showDrawer))
        navigationItem.leftBarButtonItem = menuButton
        
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(goToCart))
        navigationItem.rightBarButtonItem = cartButton
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setDelegates(){
        furnitureCollectionView.delegate = self
        furnitureCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }

    private func xibRegister(){
        furnitureCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        sliderCollectionView.register(UINib(nibName: "ImageSliderCell", bundle: nil), forCellWithReuseIdentifier: "ImageSliderCell")
    }
    
    //wrong
    private func setSliderScrollView(){
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        sliderPageControl.numberOfPages = homeViewModel.sliderImages.count
        sliderPageControl.currentPage = Int(page)
    }
    
    //MARK: - @objc Functions
    @objc func showDrawer(){
        homeViewDelegate?.showDrawer()
    }

    @objc func goToCart(){
        let nextViewController = CartViewController.loadFromNib()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func showNextImage() {
        currImg = (currImg == 3) ? 0 : (currImg+1)
        let indexPath = IndexPath(item: currImg, section: 0)
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //MARK: - IBActions
    @IBAction func pageChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        let indexPath = IndexPath(item: current, section: 0)
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currImg = current
    }
}

//MARK: - CollectionView Delegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == furnitureCollectionView{
            return 4
        }
        return homeViewModel.sliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == furnitureCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            //wrong
            cell.setContraints(lblname: homeViewModel.furnitureData[indexPath.row]["name"] as! String, lblPosition: homeViewModel.furnitureData[indexPath.row]["lblPosition"] as! Positions, imgName: homeViewModel.furnitureData[indexPath.row]["imgName"] as! String, imgPosition: homeViewModel.furnitureData[indexPath.row]["imgPosition"] as! Positions)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCell", for: indexPath) as! ImageSliderCell
        cell.sliderImage.image = UIImage(named: homeViewModel.sliderImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == furnitureCollectionView{
            let nextViewController = ProductListViewController.loadFromNib() as! ProductListViewController
            //wrong
            
            nextViewController.productCategoryId = indexPath.row + 1
//            let vc = ProductListViewController.loadFormNib()
//            vc.title =
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == furnitureCollectionView{
            let availableWidth = collectionView.bounds.width
            let spacing: CGFloat = 45
            let cellWidth = (availableWidth - spacing) / 2
            return CGSize(width: cellWidth, height: cellWidth)
        }
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView == furnitureCollectionView) ? 15 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView == furnitureCollectionView) ? 15 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == furnitureCollectionView{
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
        return UIEdgeInsets.zero
    }
}
