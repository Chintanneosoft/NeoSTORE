//
//  ProductsDetailCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 25/08/23.
//

import UIKit
import SDWebImage

class ProductsDetailCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOutOfStock: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var productImageCollection: UICollectionView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var tvDescription: UITextView!
    
    var productImagesData: [ProductImage]?
    var productImgURLs: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDelegates()
        xibRegister()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        self.tvDescription.text = productDescription
        self.lblDescription.text = "Description"
        self.productImageCollection.reloadData()
        setImages()
    }
    private func setImages(){
        for p in self.productImagesData!{
            productImgURLs += [p.image ?? ""]
        }
    }
}

extension ProductsDetailCell: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productImagesData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productImageCollection.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionViewCell", for: indexPath) as! ProductImageCollectionViewCell
//        cell.productImgs.image = productImages?[indexPath.row]
        let imgUrl = productImgURLs[indexPath.row]
        cell.setImg(url: imgUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        productImage.image = productImages?[indexPath.row]
        let imgUrl = URL(string: productImgURLs[indexPath.row] )
        productImage.sd_setImage(with: imgUrl)
    }
}
//MARK: - CollectionView DelegateFlowLayout
extension ProductsDetailCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width
        let availableHeight = collectionView.bounds.height
        let spacing: CGFloat = 50
        let cellWidth = (availableWidth - spacing) / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
