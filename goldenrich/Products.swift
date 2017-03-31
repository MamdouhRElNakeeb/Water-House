//
//  Products.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/27/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Alamofire
import UIKit

class Products: UIViewController, BasketVCDelegate {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var makeOrderTabBtn: UITabBarItem!
    @IBOutlet weak var contactUsTabBtn: UITabBarItem!
    
    let animals = ["Panda", "Lion", "Elefant"]
    
    var productData:Array< ProductItem > = Array < ProductItem >()
    
    var basketData:Array< BasketItem > = Array < BasketItem >()
    
    var progressBar: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let productsURL =  "http://apps.be4em.net/goldenrich/API/users/reloaddata"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        makeOrderTabBtn.image = makeOrderTabBtn.image?.withRenderingMode(.alwaysOriginal)
        makeOrderTabBtn.selectedImage = makeOrderTabBtn.image
        
        contactUsTabBtn.image = contactUsTabBtn.image?.withRenderingMode(.alwaysOriginal)
        contactUsTabBtn.selectedImage = contactUsTabBtn.image
    
        if basketData.count == 0{
            
            makeOrderTabBtn.badgeValue = nil
        }
        else{
            
            makeOrderTabBtn.badgeValue = "\(basketData.count)"
        }
        
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    
        loadProducts()
        
    }
    
    func loadProducts() {
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            let alert = UIAlertController(title: "Alert", message: "Problem with internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.showProgressBar()
        //creating parameters for the post request
        let parameters: Parameters=[
            "user_id": UserDefaults.standard.object(forKey: "userId")
        ]
        
        //Sending http post request
        Alamofire.request(productsURL, method: .post, parameters: parameters)
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
                        
                        self.productData.removeAll()
                        
                        let dataArray = jsonData.value(forKey: "data") as! NSDictionary
                        let productsDataArray = dataArray.value(forKey: "products") as! NSArray
                        
                        
                        for productItem in productsDataArray{
                            
                            let urlStr : String = (productItem as AnyObject).value(forKey: "photoUrl") as! String
                            let data = urlStr.data(using: .utf8)
                            let urlStrUTF8 = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            
                            
                            self.productData.append(ProductItem.init(description: (productItem as AnyObject).value(forKey: "description") as! String,
                                                                     id: (productItem as AnyObject).value(forKey: "id") as! Int,
                                                                     ordermax: (productItem as AnyObject).value(forKey: "ordermax") as! Int,
                                                                     ordermin: (productItem as AnyObject).value(forKey: "ordermin") as! Int,
                                                                     photoUrl: urlStrUTF8 as! String,
                                                                     price: (productItem as AnyObject).value(forKey: "price") as! Int,
                                                                     productName: (productItem as AnyObject).value(forKey: "productName") as! String,
                                                                     title: (productItem as AnyObject).value(forKey: "title") as! String,
                                                                     unitWeight: (productItem as AnyObject).value(forKey: "unitWeight") as! Int,
                                                                     unitsNumber: (productItem as AnyObject).value(forKey: "unitsNumber") as! Int))
                            
                            
                            print(productItem)
                            
                        }
                        
                        
                        self.productsTableView.reloadData()
                        
                    }
                }
        }
    }

    @IBAction func reloadBtnOnClick(_ sender: AnyObject) {
        loadProducts()
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

    func openBasket() {
        
        if basketData.count == 0{
            
            let alert = UIAlertController(title: "Error", message: "You must add one order at least!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let basketVC = storyBoard.instantiateViewController(withIdentifier: "Basket") as! Basket
            
            basketVC.basketData = basketData
            basketVC.delegate = self
            self.navigationController?.pushViewController(basketVC, animated: true)
        }
        
    }
    
    func openContacts()  {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basketVC = storyBoard.instantiateViewController(withIdentifier: "Contacts") as! ContactUs

        self.navigationController?.pushViewController(basketVC, animated: true)
    }
    
    func didFinishSecondVC(basketVC: Basket) {
        self.basketData = basketVC.basketData
        refreshTable()
    }
    
    func refreshTable() {
        productsTableView.reloadData()
        
        if basketData.count == 0{
            
            makeOrderTabBtn.badgeValue = nil
        }
        else{
            makeOrderTabBtn.badgeValue = "\(basketData.count)"
        }

    }
    
    
}


extension Products : UITableViewDataSource, ProductCellDelegate, UITabBarDelegate
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
        
        
        let urlStr : String = productData[indexPath.row].photoUrl
        let data = urlStr.data(using: .utf8)
        let urlStrUTF8 = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        let photoUrl = urlStrUTF8?.replacingOccurrences(of: " ", with: "%20")
    
        print(photoUrl)
 
        cell.productImage.sd_setImage(with: URL(string: photoUrl!))
        
        
        cell.productNameLabel.text = productData[indexPath.row].productName
        cell.productPriceLabel.text = "\(productData[indexPath.row].price) L.E"
        cell.productCellDelegate = self
        cell.tag = indexPath.row
        
        return cell
    }
    
    func didPressButton(tag: Int, count: Int) {
        print("I have pressed a button with a tag: \(tag)")
        
        basketData.append(BasketItem.init(productId: productData[tag].id, basketItemId: 0, productName: productData[tag].productName, quantity: count, price: count * productData[tag].price))
        
        switch makeOrderTabBtn.badgeValue {
        case nil:
            makeOrderTabBtn.badgeValue = "1"
            break
        default:
            makeOrderTabBtn.badgeValue = "\(Int(makeOrderTabBtn.badgeValue!)! + 1)"
            break
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        switch item {
        case makeOrderTabBtn:
            openBasket()
            break
        case contactUsTabBtn:
            openContacts()
            break
        default:
            return
        }
    }
}


