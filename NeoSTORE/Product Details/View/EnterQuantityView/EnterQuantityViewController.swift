//
//  EnterQuantityView.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 26/08/23.
//

import UIKit

//MARK: - EnterQuantityViewController
class EnterQuantityViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblEnterQty: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var tfEnterQty: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var enterQuantityScrollView: UIScrollView!
    
    //properties
    var productImgURL: String?
    var productName: String?
    var productId: Int?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setTapGestures()
        addObservers()
        // Do any additional setup after loading the view.
    }

    //MARK: - Functions
    private func setUpUI(){
        imgProduct.sd_setImage(with: URL(string: productImgURL ?? ""))
        lblProductName.text = productName
        
        containerView.layer.cornerRadius = 10
        
        btnSubmit.titleLabel?.font = UIFont(name: Font.fontBold.rawValue, size: 20)
        btnSubmit.layer.cornerRadius = 5
        
        tfEnterQty.becomeFirstResponder()
        tfEnterQty.delegate = self
        
        self.mainScrollView = enterQuantityScrollView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - @objc Functions
    @objc override func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.mainScrollView?.contentInset ?? UIEdgeInsets.zero
        contentInset.bottom = keyboardFrame.size.height + 20
        mainScrollView?.contentInset = contentInset
        mainScrollView?.contentSize = CGSize(width: mainScrollView?.bounds.width ?? 0, height: (mainScrollView?.bounds.height ?? 0) - 100)
    }
   
    
    //MARK: - IBActions
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        let enterQuantityViewModel = EnterQuantityViewModel()
        enterQuantityViewModel.enterQuantityViewModelDelegate = self
        enterQuantityViewModel.callAddToCart(productId:productId ?? 0 , quantity: Int(tfEnterQty.text ?? "0") ?? 0)
    }

}


//MARK: - EnterQuantityViewModelDelegate
extension EnterQuantityViewController: EnterQuantityViewModelDelegate{
    //wrong
    func ratingResult(cartCount: Int,title: String,msg: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .updateCart, object: nil, userInfo: ["cartCount":cartCount])
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    if msg == "Added to cart"{
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            
                alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - TextField Delegate
extension EnterQuantityViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.count ?? 0) + string.count <= 2 {
            return true
        }
        return false
    }
}
