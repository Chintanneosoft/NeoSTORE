//
//  ProductsDetailCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 25/08/23.
//

import UIKit

class ProductsDetailCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOutOfStock: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var productImageCollection: UICollectionView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var tvDescription: UITextView!
    
    var productImagesData: [ProductImage]?
    var productImages: [UIImage]?
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
//        setImage(url:imgName)
        self.productImagesData = productImages
        self.lblDescription.text = productDescription
        self.productImageCollection.reloadData()
    }
    private func setImages(){
        let productListViewModel = ProductListViewModel()
        for p in productImagesData!{
            let url = URL(string:p.image ?? "")
            productListViewModel.callFetchImages(url: url!){
                response in
                switch response{
                case .success(let image):
                    DispatchQueue.main.async {
                        self.productImages?.append(image)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension ProductsDetailCell: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productImagesData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productImageCollection.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionViewCell", for: indexPath) as! ProductImageCollectionViewCell
        cell.productImgs.image = productImages?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productImage.image = productImages?[indexPath.row]
    }
}
