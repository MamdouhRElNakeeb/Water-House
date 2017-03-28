//
//  Products.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/27/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Alamofire
import UIKit

class Products: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    let animals = ["Panda", "Lion", "Elefant"]
    
    var productData:Array< ProductItem > = Array < ProductItem >()
    var progressBar: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let productsURL =  "http://apps.be4em.net/goldenrich/API/users/reloaddata"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        

        
        loadProducts()
        
    }
    
    func loadProducts() {
        
        self.showProgressBar()
        //creating parameters for the post request
        let parameters: Parameters=[
            "user_id": UserDefaults.standard.object(forKey: "userId")
        ]
        
        //Sending http post request
        Alamofire.request(productsURL, method: .post, parameters: parameters)
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
                        
                        //self.showProgressBar()
                        
                        let dataArray = jsonData.value(forKey: "data") as! NSDictionary
                        let productsDataArray = dataArray.value(forKey: "products") as! NSArray
                        
                        for productItem in productsDataArray{
                            
                            print(productItem)
                            self.productData.append(ProductItem.init(description: (productItem as AnyObject).value(forKey: "description") as! String,
                                                                     id: (productItem as AnyObject).value(forKey: "id") as! Int,
                                                                     ordermax: (productItem as AnyObject).value(forKey: "ordermax") as! Int,
                                                                     ordermin: (productItem as AnyObject).value(forKey: "ordermin") as! Int,
                                                                     photoUrl: (productItem as AnyObject).value(forKey: "photoUrl") as! String,
                                                                     price: (productItem as AnyObject).value(forKey: "price") as! Int,
                                                                     productName: (productItem as AnyObject).value(forKey: "productName") as! String,
                                                                     title: (productItem as AnyObject).value(forKey: "title") as! String,
                                                                     unitWeight: (productItem as AnyObject).value(forKey: "unitWeight") as! Int,
                                                                     unitsNumber: (productItem as AnyObject).value(forKey: "unitsNumber") as! Int))
                            
                            
                        }
                        print(self.productData[3].price)
                        
                        self.productsTableView.reloadData()
                        
                    }
                    
                    //displaying the message in label
                    //print(jsonData.value(forKey: "message") as! String?)
                }
        }
    }

    /*
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        
        cell.productImage.sd_setImage(with: URL(string: productData[indexPath.row].photoUrl))
        
        //cell.productImage.image = UIImage(named: (animals[indexPath.row] + ".jpg"))
        cell.productNameLabel.text = productData[indexPath.row].productName
        cell.productPriceLabel.text = "\(productData[indexPath.row].price)"

        return (cell)
    }
    
    */

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


extension Products : UITableViewDataSource, ProductCellDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        
        cell.productImage.sd_setImage(with: URL(string: productData[indexPath.row].photoUrl))
        
        //cell.productImage.image = UIImage(named: (animals[indexPath.row] + ".jpg"))
        cell.productNameLabel.text = productData[indexPath.row].productName
        cell.productPriceLabel.text = "\(productData[indexPath.row].price)"
        cell.productCellDelegate = self
        cell.tag = indexPath.row
        
        return cell
    }
    
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        
    }
}


