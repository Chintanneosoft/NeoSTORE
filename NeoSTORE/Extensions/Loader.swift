//
//  File.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

import Foundation
import UIKit
extension UIViewController{
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
    //MARK:- Hiding loader view
    func hideLoader(viewLoaderScreen: UIView?) {
        viewLoaderScreen?.isHidden = true
    }
}
