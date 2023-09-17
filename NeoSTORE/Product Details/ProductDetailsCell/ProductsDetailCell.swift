import UIKit
import SDWebImage

//MARK: - ProductDetailCellDelegate
protocol ProductDetailCellDelegate:NSObject{
    func shareTapped(productImg: UIImage)
}

//MARK: - ProductsDetailCell
class ProductsDetailCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOutOfStock: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTextDescription: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var productImageCollection: UICollectionView!
    
    weak var productDetailCellDelegate: ProductDetailCellDelegate?
    
    //Properties
    var selectState = true
    var productImagesData: [ProductImage]?
    var productImgURLs: [String] = []
    
    //MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setDelegates()
        xibRegister()
        setUpUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Functions
    private func setUpUI(){
        containerView.layer.cornerRadius = 5
        lblDescription.font = UIFont(name: Font.fontRegular.rawValue, size: 15)
        lblTextDescription.font = UIFont(name: Font.fontThin.rawValue, size: 10)
    }
    
    private func setDelegates(){
        productImageCollection.delegate = self
        productImageCollection.dataSource = self
    }
    
    private func xibRegister(){
        productImageCollection.register(UINib(nibName: "ProductImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductImageCollectionViewCell")
    }
    
    func setDetails(productImages: [ProductImage],productDescription: String, price: Int){
        lblPrice.text = "Rs: " + String(price)
        self.productImagesData = productImages
        self.lblTextDescription.text = productDescription
        self.lblDescription.text = "DESCRIPTION"
        self.productImageCollection.reloadData()
        setImages()
    }
    
    private func setImages(){
        for p in self.productImagesData!{
            productImgURLs += [p.image ?? ""]
        }
    }
    
    @IBAction func btnShareTapped(_ sender: UIButton) {
        self.productDetailCellDelegate?.shareTapped(productImg: productImage.image!) 
    }
}

//MARK: - CollectionView Delegate and DataSource
extension ProductsDetailCell: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productImagesData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = productImageCollection.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionViewCell", for: indexPath) as! ProductImageCollectionViewCell
        let imgUrl = productImgURLs[indexPath.row]
        cell.setImg(url: imgUrl)
        let borderColor: CGColor?
        
        if indexPath.row == 0{
            productImage.sd_setImage(with: URL(string: imgUrl))
        }
        
        borderColor =  selectState ? changeSelectedCellUI(idx: indexPath.row, s: selectState) : changeSelectedCellUI(idx: indexPath.row, s: false)
        selectState = false
        
        cell.layer.borderColor = borderColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        let imgUrl = URL(string: productImgURLs[indexPath.row] )
        productImage.sd_setImage(with: imgUrl)
        cell.layer.borderColor = UIColor(named: "Primary Background")?.cgColor
        collectionView.cellForItem(at: IndexPath(row: 0, section: 0))?.layer.borderColor = indexPath.row == 0 ? UIColor(named: "Primary Background")?.cgColor : UIColor.black.cgColor
        productImageCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func changeSelectedCellUI(idx: Int,s: Bool) -> CGColor{
        return s ? (UIColor(named: "Primary Background")?.cgColor ?? UIColor.black.cgColor) : UIColor.black.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.layer.borderColor = UIColor.black.cgColor
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension ProductsDetailCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width
        let cellWidth = availableWidth / 2.5
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
