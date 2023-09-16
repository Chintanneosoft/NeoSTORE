//
//  ProductDetailsViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 20/08/23.
//

import UIKit


//MARK: - ProductDetailsViewController
class ProductDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var productsDetailsTableView: UITableView!
    @IBOutlet weak var btnBuyNow: UIButton!
    @IBOutlet weak var btnRate: UIButton!
    
    //Viewmodel Object
    let productDetailsViewModel = ProductDetailsViewModel()
    
    //properties
    var productId : Int?
    var productCategory : String?
    var loaderView: UIView?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        xibRegister()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
        callViewModelFetchProductDetails()
    }
    
    //MARK: - Functions
    private func setUpUI(){
        btnRate.layer.cornerRadius = 5
        btnBuyNow.layer.cornerRadius = 5
        btnRate.titleLabel?.font = UIFont(name: Font.fontBold.rawValue, size: 20)
        btnBuyNow.titleLabel?.font = UIFont(name: Font.fontBold.rawValue, size: 20)
    }
    
    private func setUpNavBar(){
            
        setNavBarStyle(fontName: Font.fontRegular.rawValue, fontSize: 20)
        navigationItem.title = productDetailsViewModel.productsDetails?.data?.name
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
            
            // navigation bar back image
            navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
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
    
    private func callViewModelFetchProductDetails(){
        self.showLoader()
        productDetailsViewModel.productDetailsViewModelDelegate = self
        productDetailsViewModel.callProductDetails(productId: productId ?? 0)
    }
    
    func shareContent(productImg: UIImage) {
        let text = URL(string: "https://www.neosofttech.com/")
        
        let name = productDetailsViewModel.productsDetails?.data?.name
        
        let image = productImg

        let itemsToShare = [name ?? "", text ?? "", image] as [Any]

          let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

          // Customize the UIActivityViewController as needed
          activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]

          self.present(activityViewController, animated: true, completion: nil)
      }
    
    //MARK: - IBActions
    @IBAction func btnRateTapped(_ sender: UIButton) {
        let ratingPopUpUIView = RatingPopUiViewController(nibName: "RatingPopUiViewController", bundle: nil)
        ratingPopUpUIView.ratingUpdateDataDelegate = self
        ratingPopUpUIView.modalPresentationStyle = .overCurrentContext
        ratingPopUpUIView.productId = productId
        ratingPopUpUIView.productName = productDetailsViewModel.productsDetails?.data?.name
        ratingPopUpUIView.productImgURL = productDetailsViewModel.productsDetails?.data?.productImages?[0].image
        self.navigationController?.present(ratingPopUpUIView, animated: false)
    }
    
    @IBAction func btnBuyNowTapped(_ sender: UIButton) {
        let enterQuantityView = EnterQuantityViewController(nibName: "EnterQuantityViewController", bundle: nil)
        enterQuantityView.modalPresentationStyle = .overCurrentContext
        enterQuantityView.productId = productId
        enterQuantityView.productName = productDetailsViewModel.productsDetails?.data?.name
        enterQuantityView.productImgURL = productDetailsViewModel.productsDetails?.data?.productImages?[0].image
        self.navigationController?.present(enterQuantityView, animated: false)
    }

}

//MARK: - TableView Delegate and DataSource
extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsNameCell", for: indexPath) as! ProductsNameCell
            cell.setDetails(productName: productDetailsViewModel.productsDetails?.data?.name ?? "", producerName: productDetailsViewModel.productsDetails?.data?.producer ?? "", category: productCategory ?? "", rating: productDetailsViewModel.productsDetails?.data?.rating ?? 0)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsDetailCell", for: indexPath) as! ProductsDetailCell
            cell.setDetails(productImages: productDetailsViewModel.productsDetails?.data?.productImages ?? [], productDescription: productDetailsViewModel.productsDetails?.data?.dataDescription ?? "", price: productDetailsViewModel.productsDetails?.data?.cost ?? 0)
            cell.productDetailCellDelegate = self
            cell.selectionStyle = .none
            return cell
        default:
            print("")
        }
        let cell = productsDetailsTableView.dequeueReusableCell(withIdentifier: "ProductsNameCell", for: indexPath)
        return cell
    }
    
}


//MARK: - ProductDetailsViewModelDelegate
extension ProductDetailsViewController: ProductDetailsViewModelDelegate{
    func setProductDetails() {
        DispatchQueue.main.async {
            self.productsDetailsTableView.reloadData()
            self.navigationItem.title = self.productDetailsViewModel.productsDetails?.data?.name
            self.hideLoader()
        }
    }
    
    func failureProductDetails(msg: String) {
        print(msg)
        DispatchQueue.main.async {
            self.showAlert(title: "Error", msg: msg)
        }
    }
    
}

//MARK: - RatingUpdateData
extension ProductDetailsViewController: RatingUpdateData{
    func updateData() {
        callViewModelFetchProductDetails()
    }
}

//MARK: -
extension ProductDetailsViewController: ProductDetailCellDelegate{
    func shareTapped(productImg: UIImage) {
        shareContent(productImg: productImg)
    }
}
