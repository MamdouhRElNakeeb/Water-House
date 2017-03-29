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
        let basketProductItemJSON: NSMutableDictionary = NSMutableDictionary()
        
        basketProductItemJSON.setValue(self.productId, forKey: "productId")
        basketProductItemJSON.setValue(self.price, forKey: "price")
        basketProductItemJSON.setValue(self.productName, forKey: "name")
        
        
        basketItemJSON.setValue(basketProductItemJSON, forKey: "product")
        basketItemJSON.setValue(self.quantity, forKey: "quantity")
        /*
        var dict : [String: AnyObject] = [:]
        dict["id"] = (self.id) as AnyObject?
        dict["price"] = (self.price ) as AnyObject
        dict["productName"] = (self.productName) as AnyObject
        
        var dict2 : [String: AnyObject] = [:]
        dict2["product"] = dict as AnyObject
        dict2["quantity"] = (self.quantity) as AnyObject
        */
        return basketItemJSON
    }
    
}
