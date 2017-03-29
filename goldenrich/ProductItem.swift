//
//  ProductItem.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/27/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class ProductItem {
    
    var description = ""
    var id = 1
    var ordermax = 100
    var ordermin = 1
    var photoUrl = ""
    var price = 1
    var productName = ""
    var title = ""
    var unitWeight = 1000
    var unitsNumber = 1
    
    init(description: String, id: Int, ordermax: Int, ordermin: Int, photoUrl: String, price: Int, productName: String, title: String, unitWeight: Int, unitsNumber: Int) {
        self.description = description
        self.id = id
        self.ordermax = ordermax
        self.ordermin = ordermin
        self.photoUrl = photoUrl
        self.price = price
        self.productName = productName
        self.title = title
        self.unitWeight = unitWeight
        self.unitsNumber = unitsNumber
    }
    
}
