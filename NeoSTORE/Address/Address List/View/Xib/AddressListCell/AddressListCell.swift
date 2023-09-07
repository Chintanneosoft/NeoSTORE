//
//  AddressListCell.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 04/09/23.
//

import UIKit

protocol AddressListCellDelegate: NSObject{
    func btnSelectTapped(btnTag: Int)
    func btnCancelTapped(btnTag: Int)
}

class AddressListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    weak var addressListCellDelegate: AddressListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setUpUI(){
        
        lblTitle.font = UIFont(name: Font.fontRegular.rawValue, size: 22)
        lblAddress.font = UIFont(name: Font.fontThin.rawValue, size: 15)
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 0.1
    }
    
    @IBAction func btnSelectTapped(_ sender: UIButton) {
        addressListCellDelegate?.btnSelectTapped(btnTag: sender.tag)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        addressListCellDelegate?.btnCancelTapped(btnTag: sender.tag)
        
    }
    
}
