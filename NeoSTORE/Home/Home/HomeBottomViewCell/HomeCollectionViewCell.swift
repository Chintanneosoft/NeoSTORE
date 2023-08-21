//
//  HomeCollectionViewCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 21/08/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    private func setUpUI(){
        lbl.font = UIFont(name: Font.fontRegular.rawValue, size: 23)
    }
    func setContraints(lblname: String,lblPosition:Positions,imgName: String,imgPosition:Positions){
        lbl.text = lblname
        img.image = UIImage(named: imgName)
        applyConstraints(view: lbl, position: lblPosition)
        applyConstraints(view: img, position: imgPosition)
    }
    
    func applyConstraints(view: UIView,position:Positions){
        view.translatesAutoresizingMaskIntoConstraints = false
        if view == img {
            let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
            let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
            view.addConstraints([widthConstraint, heightConstraint])
        }
        switch position {
        case .topLeft:
            let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 15.0)
            let leftConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 15.0)
            containerView.addConstraints([topConstraint, leftConstraint])
        case .bottomLeft:
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -15.0)
            let leftConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 15.0)
            containerView.addConstraints([bottomConstraint, leftConstraint])
        case .topRight:
            let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 15.0)
            let rightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -15.0)
            containerView.addConstraints([topConstraint, rightConstraint])
        case .bottomRight:
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -15.0)
            let rightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -15.0)
            containerView.addConstraints([bottomConstraint, rightConstraint])
        }
    }
}
