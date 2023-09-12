//
//  RatingPopUiViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 31/08/23.
//

import UIKit
import SDWebImage

//MARK: - RatingUpdateData protocol
protocol RatingUpdateData:NSObject{
    func updateData()
}

//MARK: - RatingPopUiViewController
class RatingPopUiViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet var starImgs: [UIImageView]!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var btnRateNow: UIButton!
    
    //MARK: - RatingUpdateData object
    weak var ratingUpdateDataDelegate : RatingUpdateData?
    
    //properties
    var imgtapped: Int?
    var productImgURL: String?
    var productName: String?
    var productId: Int?
    var rating:Int = 0
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    //MARK: - Functions
    private func setUpUI(){
        
        //image
        imgProduct.sd_setImage(with: URL(string: productImgURL ?? ""))
        
        //label
        lblProductName.text = productName
        
        //View
        containerView.layer.cornerRadius = 10
        
        //button
        btnRateNow.titleLabel?.font = UIFont(name: Font.fontBold.rawValue, size: 20)
        btnRateNow.layer.cornerRadius = 5
        
        //Tap Gestures
        let img1Tap = UITapGestureRecognizer(target: self, action: #selector(handleOneStar))
        let img2Tap = UITapGestureRecognizer(target: self, action: #selector(handleTwoStar))
        let img3Tap = UITapGestureRecognizer(target: self, action: #selector(handleThreeStar))
        let img4Tap = UITapGestureRecognizer(target: self, action: #selector(handleFourStar))
        let img5Tap = UITapGestureRecognizer(target: self, action: #selector(handleFiveStar))
        
        star1.isUserInteractionEnabled = true
        star1.addGestureRecognizer(img1Tap)
        star2.isUserInteractionEnabled = true
        star2.addGestureRecognizer(img2Tap)
        star3.isUserInteractionEnabled = true
        star3.addGestureRecognizer(img3Tap)
        star4.isUserInteractionEnabled = true
        star4.addGestureRecognizer(img4Tap)
        star5.isUserInteractionEnabled = true
        star5.addGestureRecognizer(img5Tap)
        
    }
    
    func setRating(rate: Int) {
           for i in 1...5 {
               if i <= rate {
                   starImgs[i-1].image = UIImage(named: "star_check")
               }
               else {
                   starImgs[i-1].image = UIImage(named: "star_unchek")
               }
           }
       }
    
    //MARK: - @objc
    @objc func handleOneStar() {
        if rating == 1{
            setRating(rate: 0)
            rating = 0
        }
        else {
            setRating(rate: 1)
            rating = 1
        }
        }
        @objc func handleTwoStar() {
            setRating(rate: 2)
            rating = 2
        }
        @objc func handleThreeStar() {
            setRating(rate: 3)
            rating = 3
        }
        @objc func handleFourStar() {
            setRating(rate: 4)
            rating = 4
        }
        @objc func handleFiveStar() {
            setRating(rate: 5)
            rating = 5
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
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.ratingUpdateDataDelegate?.updateData()
                    self.dismiss(animated: false, completion: nil)
                    self.dismiss(animated: false)
                }
                alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
