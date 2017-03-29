//
//  File.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class OrderItem {
    
    var date = 0
    var id = 1
    
    var orderItem:Array< BasketItem > = Array < BasketItem >()
    
    var orderNumber = 1
    var orderStatus = ""
    var totalCost = 1
    
    init(date: Int, id: Int, orderItem:Array< BasketItem >, orderNumber: Int, orderStatus: String, totalCost: Int) {
        self.date = date
        self.id = id
        self.orderItem = orderItem
        self.orderNumber = orderNumber
        self.orderStatus = orderStatus
        self.totalCost = totalCost
    }
    
    init(){
        
    }
    
}
