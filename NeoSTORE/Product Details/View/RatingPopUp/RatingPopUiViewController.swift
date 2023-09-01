//
//  RatingPopUiViewController.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 31/08/23.
//

import UIKit
import SDWebImage


protocol RatingUpdateData:NSObject{
    func updateData()
}

class RatingPopUiViewController: UIViewController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet var btnRatings: [UIButton]!
    
    @IBOutlet weak var btnRateNow: UIButton!
    weak var ratingUpdateDataDelegate : RatingUpdateData?
    
    var productImgURL: String?
    var productName: String?
    var productId: Int?
    var rating:Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        setDelegates()
    }
    private func setDelegates(){
    }
    private func setUpUI(){
        imgProduct.sd_setImage(with: URL(string: productImgURL ?? ""))
        lblProductName.text = productName
        
        containerView.layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAtTap))
        superView.addGestureRecognizer(tapGesture)
    }
    @objc func dismissAtTap(){
        self.dismiss(animated: false)
    }
    
    @IBAction func ratingTapped(_ sender: UIButton) {
        var cnt = 0
        rating = sender.tag
        for btn in btnRatings{
            if cnt < sender.tag{
                btn.isSelected = true
            }
            else{
                btn.isSelected = false
            }
            cnt += 1
        }
    }
    
    @IBAction func btnRateNowTapped(_ sender: UIButton) {
        let ratingPopUpViewModel = RatingPopUpViewModel()
        ratingPopUpViewModel.ratingPopUpViewModelDelegate = self
        ratingPopUpViewModel.callPostRating(productId:productId ?? 0 , rating: rating)
    }
    
}

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
