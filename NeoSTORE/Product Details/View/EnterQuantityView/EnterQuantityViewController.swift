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
    
    @IBOutlet weak var enterQuantityScrollView: UIScrollView!
    
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
        
        tfEnterQty.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.enterQuantityScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        enterQuantityScrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        enterQuantityScrollView.contentInset = contentInset
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
