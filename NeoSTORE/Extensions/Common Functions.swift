//
//  File.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

import Foundation
import UIKit
extension UIViewController{
    
    //MARK: - Loader
    func showLoader(view: UIView, aicView: inout UIView?) {
        let parentView = UIView(frame: UIScreen.main.bounds)
        parentView.isUserInteractionEnabled = false
        
        let ai = UIActivityIndicatorView()
        ai.color = .black
        ai.startAnimating()
        ai.center = parentView.center
        
        parentView.addSubview(ai)
        view.addSubview(parentView)
        
        // Assign view
        aicView = parentView
    }
    
    func hideLoader(viewLoaderScreen: UIView?) {
        viewLoaderScreen?.isHidden = true
    }
    
    //MARK: - Alert
    func showAlert(title: String,msg :String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
    }
}
