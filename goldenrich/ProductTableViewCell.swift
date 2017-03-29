//
//  ProductTableViewCell.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/27/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import SDWebImage
import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productAddBtn: UIButton!
    @IBOutlet weak var productQTxtField: UITextField!
    
    weak var productCellDelegate : ProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.layoutMargins = UIEdgeInsetsMake(0, 0, 20, 0)
        
        productAddBtn.layer.cornerRadius = 10
        productAddBtn.clipsToBounds = true

        productQTxtField.layer.borderColor = UIColor.lightGray.cgColor
        productQTxtField.layer.borderWidth = 1.0
        productQTxtField.layer.cornerRadius = 10
        productQTxtField.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ProductAddBtnOnClick(_ sender: AnyObject) {
        productCellDelegate?.didPressButton(tag: self.tag, count: Int(productQTxtField.text!)!)
        print("price:" + productPriceLabel.text!)
    }
    @IBAction func productQPlusBtnOnClick(_ sender: AnyObject) {
        //productCellDelegate?.didPressButton(sender.tag)
        
        if Int(productQTxtField.text!)! < 100{
            productQTxtField.text = "\(Int(productQTxtField.text!)! + 1)"
        }
    }
    @IBAction func productQMinusBtnOnClick(_ sender: AnyObject) {
        //productCellDelegate?.didPressButton(sender.tag)
        if Int(productQTxtField.text!)! > 1{
            productQTxtField.text = "\(Int(productQTxtField.text!)! - 1)"
        }
    }
    
}

protocol ProductCellDelegate : class {
    func didPressButton(tag: Int, count: Int)
}
