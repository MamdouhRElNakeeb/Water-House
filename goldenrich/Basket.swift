//
//  Basket.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class Basket: UIViewController {

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    let ordersURL =  "http://apps.be4em.net/goldenrich/API/orders/create"
    
    var progressBar: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let animals = ["Panda", "Lion", "Elefant"]
    
    var basketData:Array< BasketItem > = Array < BasketItem >()
    var delegate: BasketVCDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.basketTableView.reloadData()
    }

    @IBAction func backBtnOnClick(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
        delegate.didFinishSecondVC(basketVC: self)
        
    }
    
    @IBAction func confirmBtnOnClick(_ sender: AnyObject) {
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            let alert = UIAlertController(title: "Alert", message: "Problem with internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let basketDataJSONArray:NSMutableArray = NSMutableArray()
        
        do {
            
            self.showProgressBar()
           
            for basketItem in basketData{
                
                let basketItemJSON = basketItem.toJson()
                
                basketDataJSONArray.add(basketItemJSON)
            }
            
            var totalPrice: Int = 0
            
            for basketItemPrice: BasketItem in basketData{
                
                totalPrice += basketItemPrice.price
            }
            
            let basketItemJSON: NSMutableDictionary = NSMutableDictionary()
            
            print(String(format: "%.0f", (NSDate().timeIntervalSince1970 * 1000)))
            
            
            basketItemJSON.setValue(String(format: "%.0f", (NSDate().timeIntervalSince1970 * 1000)), forKey: "orderNumber")
            basketItemJSON.setValue(UserDefaults.standard.object(forKey: "userId"), forKey: "userId")
            basketItemJSON.setValue("\(totalPrice)", forKey: "totalcost")
            basketItemJSON.setValue(basketDataJSONArray, forKey: "orderItems")
            
            
            print(basketItemJSON)
            
            var request = URLRequest(url: URL(string: ordersURL)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: basketItemJSON)
        
            postOrder(request: request)
            
            
        } catch {
            print(error)
            self.hideProgressBar()
        }
 
    }
    
    func postOrder(request: URLRequest) {
        

        //Sending http post request
        Alamofire.request(request)
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
                    
                    
                    if code == 500{
                        
                    }
                    else if code == 200{
                        let alert = UIAlertController(title: "Success", message: "Order Sent Successfully", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
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

extension Basket : UITableViewDataSource, BasketCellDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return basketData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell") as! BasketTableViewCell
        
        cell.nameLabel.text = basketData[indexPath.row].productName
        cell.quantityLabel.text = "\(basketData[indexPath.row].quantity) unit"
        cell.priceLabel.text = "\(basketData[indexPath.row].price) L.E"
        cell.basketCellDelegate = self
        cell.tag = indexPath.row
        //cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        basketData.remove(at: tag)
        
        basketTableView.reloadData()
        if basketData.count == 0 {
            _ = navigationController?.popViewController(animated: true)
            delegate.didFinishSecondVC(basketVC: self)
        }
        
    }
}

protocol BasketVCDelegate {
    func didFinishSecondVC(basketVC: Basket)
}
