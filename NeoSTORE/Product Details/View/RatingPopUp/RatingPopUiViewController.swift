import UIKit
import SDWebImage

//MARK: - RatingUpdateData protocol
protocol RatingUpdateData:NSObject{
    func updateData()
}

//Wrong
//MARK: - RatingPopUiViewController
class RatingPopUiViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var starCollectionView: UICollectionView!
    @IBOutlet weak var btnRateNow: UIButton!
    
    //MARK: - RatingUpdateData object
    weak var ratingUpdateDataDelegate : RatingUpdateData?
    
    //properties
    var productImgURL: String?
    var productName: String?
    var productId: Int?
    var rating:Int = 0
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setCollectionView()
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return RatingPopUiViewController(nibName: "RatingPopUiViewController", bundle: nil)
    }
    
    private func setCollectionView(){
        starCollectionView.delegate = self
        starCollectionView.dataSource = self
        starCollectionView.register(UINib(nibName: "StarCell", bundle: nil), forCellWithReuseIdentifier: "StarCell")
    }
    
    private func setUpUI(){
        imgProduct.sd_setImage(with: URL(string: productImgURL ?? ""))
        
        lblProductName.text = productName
        
        containerView.layer.cornerRadius = 10
        btnRateNow.titleLabel?.font = UIFont.customFont(Font.fontBold, size: 20)
        btnRateNow.layer.cornerRadius = 5
    }
    
    //MARK: - IBActions
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }

    @IBAction func btnRateNowTapped(_ sender: UIButton) {
        let ratingPopUpViewModel = RatingPopUpViewModel()
        ratingPopUpViewModel.ratingPopUpViewModelDelegate = self
        ratingPopUpViewModel.callPostRating(productId:productId ?? 0 , rating: rating)
    }
}

//MARK: - RatingPopUpViewModelDelegate
extension RatingPopUiViewController: RatingPopUpViewModelDelegate{
    func ratingResult(title: String,msg: String) {
        DispatchQueue.main.async {
            self.showSingleButtonAlert(title: title, msg: msg) {
                self.dismiss(animated: false,completion: nil)
            }
        }
    }
}

//MARK: - Star CollectionViewDelegate
extension RatingPopUiViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = starCollectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as! StarCell
        cell.setStar(selected: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var tempRating = 0
        for i in 0...4{
            let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! StarCell
            if indexPath.row == 0 && rating == 1{
                cell.setStar(selected: false)
                break
            } else {
                if i<=indexPath.row{
                    cell.setStar(selected: true)
                    tempRating = tempRating + 1
                }
                else{
                    cell.setStar(selected: false)
                }
            }
        }
        rating = tempRating
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width/5 - 10
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
