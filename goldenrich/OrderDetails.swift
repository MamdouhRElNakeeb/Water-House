//
//  OrderDetails.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/29/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class OrderDetails: UIViewController {

    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderProductsTableView: UITableView!
    @IBOutlet weak var orderItemsLabel: UILabel!
    @IBOutlet weak var totalCostTabel: UILabel!
    
    var orderProductItemsData: Array <BasketItem> = Array <BasketItem>()
    
    var orderItem: OrderItem = OrderItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        orderProductsTableView.rowHeight = 80
        
        let dateFormat: DateFormat  = DateFormat()
        
        dateLabel.text = dateFormat.getDateStr(dateMilli: orderItem.date)
        
        orderIdLabel.text = "Order ID: \(orderItem.orderNumber)"
        orderItemsLabel.text = "\(orderProductItemsData.count)"
        totalCostTabel.text = "\(orderItem.totalCost) EGP"
        
        self.orderProductsTableView.reloadData()
        
    }

    @IBAction func backBtnOnClick(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func trackingBtnOnClick(_ sender: AnyObject) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let trackingVC = storyBoard.instantiateViewController(withIdentifier: "Tracking") as! Tracking
        
        trackingVC.orderItem = orderItem
        
        self.navigationController?.pushViewController(trackingVC, animated: true)
    }
}

extension OrderDetails : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return orderProductItemsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderProductCell") as! OrderProductTableViewCell
        
        
        cell.productNameLabel.text = "\(orderProductItemsData[indexPath.row].productName)"
        cell.productPriceLabel.text = "EGP \(orderProductItemsData[indexPath.row].price) X \(orderProductItemsData[indexPath.row].quantity)"
        cell.tag = indexPath.row
        
        return cell
    }
    
}











