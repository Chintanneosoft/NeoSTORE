//
//  EnterQuantityView.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 26/08/23.
//

import UIKit

class EnterQuantityViewController: UIViewController {
    @IBOutlet var superView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblEnterQty: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var tfEnterQty: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var productImgURL: String?
    var productName: String?
    var productId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }

    private func setUpUI(){
        imgProduct.sd_setImage(with: URL(string: productImgURL ?? ""))
        lblProductName.text = productName
        
        containerView.layer.cornerRadius = 10
//        let width: CGFloat = 300 // Change to your desired width
//        let height: CGFloat = 200 // Change to your desired height
//        preferredContentSize = CGSize(width: width, height: height)
//
//        view.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAtTap))
        superView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissAtTap(){
        self.dismiss(animated: false)
    }
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        let enterQuantityViewModel = EnterQuantityViewModel()
        enterQuantityViewModel.enterQuantityViewModelDelegate = self
        enterQuantityViewModel.callAddToCart(productId:productId ?? 0 , quantity: Int(tfEnterQty.text ?? "0") ?? 0)
    }
    

}

extension EnterQuantityViewController: EnterQuantityViewModelDelegate{
    
    func ratingResult(title: String,msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.dismiss(animated: false, completion: nil)
                    self.dismiss(animated: false)
                }
                alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
