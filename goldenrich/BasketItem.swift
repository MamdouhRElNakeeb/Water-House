//
//  BasketItem.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class BasketItem{
    
    var productId = 1
    var basketItemId = 1
    var productName = ""
    var quantity = 1
    var price = 1
    
    init(productId: Int, basketItemId: Int, productName: String, quantity: Int, price: Int) {
        self.productId = productId
        self.basketItemId = basketItemId
        self.productName = productName
        self.quantity = quantity
        self.price = price
    }
    
    func toJson() -> NSMutableDictionary {
        
        let basketItemJSON: NSMutableDictionary = NSMutableDictionary()
        basketItemJSON.setValue(self.productId, forKey: "productId")
        basketItemJSON.setValue(self.quantity, forKey: "quantity")
        
        return basketItemJSON
    }
    
}
