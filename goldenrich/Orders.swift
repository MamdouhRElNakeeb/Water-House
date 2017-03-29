//
//  Orders.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class Orders: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var ordersTableView: UITableView!
    
    var ordersData:Array< OrderItem > = Array < OrderItem >()
    
    var progressBar: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let ordersURL =  "http://apps.be4em.net/goldenrich/API/users/reloaddata"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ordersTableView.rowHeight = 100
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadOrders()
    }

    @IBAction func reloadBtnOnClick(_ sender: AnyObject) {
        loadOrders()
    }
    
    func loadOrders() {
        
        self.showProgressBar()
        //creating parameters for the post request
        let parameters: Parameters=[
            "user_id": UserDefaults.standard.object(forKey: "userId")
        ]
        
        //Sending http post request
        Alamofire.request(ordersURL, method: .post, parameters: parameters)
            //.validate(contentType: ["application/json"])
            //.validate(contentType: ["application/x-www-form-urlencoded;charset=UTF-8"])
            .responseJSON
            {
                response in
                
                self.hideProgressBar()
                
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    let code = jsonData.value(forKey: "code") as! Int
                    
                    //jsonData.data(using: String.Encoding.utf8)
                    
                    if code == 500{
                        
                    }
                    else if code == 200{
                        self.ordersData.removeAll()
                        
                        let dataArray = jsonData.value(forKey: "data") as! NSDictionary
                        let ordersDataArray = dataArray.value(forKey: "userOrders") as! NSArray
                        
                        
                        for orderItem in ordersDataArray{
                            
                            var orderItemProducts: Array<BasketItem> = Array<BasketItem>()
                            
                            //let orderItemsArray = (orderItem as AnyObject).value(forKey: "orderItem") as! NSDictionary
                            let orderItemsDataArray = (orderItem as AnyObject).value(forKey: "orderItem") as! NSArray
                            
                            for orderItemProduct in orderItemsDataArray {
                                
                                
                                let productItem = (orderItemProduct as AnyObject).value(forKey: "product") as! NSDictionary
                                
                                orderItemProducts.append(BasketItem.init(productId: (productItem as AnyObject).value(forKey: "id") as! Int,
                                                                         basketItemId: (orderItemProduct as AnyObject).value(forKey: "id") as! Int,
                                                                         productName: (productItem as AnyObject).value(forKey: "productName") as! String,
                                                                         quantity: (orderItemProduct as AnyObject).value(forKey: "quantity") as! Int,
                                                                         price: (productItem as AnyObject).value(forKey: "price") as! Int))
                                
                            }
                            
                            self.ordersData.append(OrderItem.init(date: (orderItem as AnyObject).value(forKey: "date") as! Int,
                                                                     id: (orderItem as AnyObject).value(forKey: "id") as! Int,
                                                                     orderItem: orderItemProducts,
                                                                     orderNumber: (orderItem as AnyObject).value(forKey: "orderNumber") as! Int,
                                                                     orderStatus: "",
                                                                     totalCost: (orderItem as AnyObject).value(forKey: "totalCost") as! Int))
                            
                            print(self.ordersData[0])
                            
                        }
                        
                        
                        self.ordersTableView.reloadData()
                        
                    }
                    
                    //displaying the message in label
                    //print(jsonData.value(forKey: "message") as! String?)
                }
        }
    }
    
    func showProgressBar(){
        progressBar.center = self.view.center
        progressBar.hidesWhenStopped = true
        progressBar.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(progressBar)
        
        progressBar.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideProgressBar() {
        progressBar.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

}

extension Orders : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ordersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! OrderTableViewCell
        
        
        cell.dateLabel.text = "\(ordersData[indexPath.row].date)"
        cell.totalCostLabel.text = "\(ordersData[indexPath.row].totalCost) L.E"
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let orderDetails = storyBoard.instantiateViewController(withIdentifier: "OrderDetails") as! OrderDetails
        
        orderDetails.orderItem = ordersData[indexPath.row]
        orderDetails.orderProductItemsData = ordersData[indexPath.row].orderItem
        
        self.navigationController?.pushViewController(orderDetails, animated: true)
        
    }
    
    
}



