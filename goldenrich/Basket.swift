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
    
    
    let ordersURL =  "http://apps.be4em.net/goldenrich/API/users/reloaddata"
    
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
        
        /*
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let productsVC = storyBoard.instantiateViewController(withIdentifier: "Products") as! Products
        
        productsVC.basketData = self.basketData
        self.navigationController?.pushViewController(productsVC, animated: true)
        */
    }
    
    @IBAction func confirmBtnOnClick(_ sender: AnyObject) {
        
        let basketDataJSONArray:NSMutableArray = NSMutableArray()
        
        do {
            
           
            for basketItem in basketData{
                
                let basketItemJSON = basketItem.toJson()
                
                basketDataJSONArray.add(basketItemJSON)
            }
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: basketDataJSONArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Do this for print data only otherwise skip
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            
            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [AnyObject].
            //let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
            //print(json)
            
            
        } catch {
            print(error)
        }
        
    }
    
    func postOrder() {
        
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
                        
                        
                        let dataArray = jsonData.value(forKey: "data") as! NSDictionary
                        let ordersDataArray = dataArray.value(forKey: "userOrders") as! NSArray
                    
                        
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
        cell.quantityLabel.text = "\(basketData[indexPath.row].quantity)"
        cell.priceLabel.text = "\(basketData[indexPath.row].price)"
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
