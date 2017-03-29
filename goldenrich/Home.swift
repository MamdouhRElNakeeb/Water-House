//
//  Home.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/23/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class Home: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var lastOrdersView: UIView!
    @IBOutlet weak var aboutUsView: UIView!
    @IBOutlet weak var contactUsView: UIView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        roundViewCorners(view: productsView)
        roundViewCorners(view: lastOrdersView)
        roundViewCorners(view: aboutUsView)
        roundViewCorners(view: contactUsView)
 
        let productsBtnTap = UITapGestureRecognizer(target: self, action: #selector(openProducts))
        productsBtnTap.delegate = self
        productsView.addGestureRecognizer(productsBtnTap)
        
        let ordersBtnTap = UITapGestureRecognizer(target: self, action: #selector(openOrders))
        ordersBtnTap.delegate = self
        lastOrdersView.addGestureRecognizer(ordersBtnTap)
        
        let aboutBtnTap = UITapGestureRecognizer(target: self, action: #selector(openAbout))
        aboutBtnTap.delegate = self
        aboutUsView.addGestureRecognizer(aboutBtnTap)
        
        let contactsBtnTap = UITapGestureRecognizer(target: self, action: #selector(openContacts))
        contactsBtnTap.delegate = self
        contactUsView.addGestureRecognizer(contactsBtnTap)

    }

    func openProducts() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Products") as! Products
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openOrders() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Orders") as! Orders
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openAbout() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "About") as! AboutUs
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openContacts() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Contacts") as! ContactUs
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    func roundViewCorners(view: UIView){
         
        // Add border
        let borderLayer = CAShapeLayer()
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center

        switch view {
        case self.productsView:
            rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomRight , .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            borderLayer.path = rectShape.path // Reuse the Bezier path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.white.cgColor
            borderLayer.lineWidth = 3
            borderLayer.frame = view.bounds
            view.layer.addSublayer(borderLayer)
            view.layer.mask = rectShape
            break
        case self.lastOrdersView:
            rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft , .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            borderLayer.path = rectShape.path // Reuse the Bezier path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.white.cgColor
            borderLayer.lineWidth = 3
            borderLayer.frame = view.bounds
            view.layer.addSublayer(borderLayer)
            view.layer.mask = rectShape
            break
        case self.aboutUsView:
            rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft , .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            borderLayer.path = rectShape.path // Reuse the Bezier path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.white.cgColor
            borderLayer.lineWidth = 3
            borderLayer.frame = view.bounds
            view.layer.addSublayer(borderLayer)
            view.layer.mask = rectShape
            break
        case self.contactUsView:
            rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomRight , .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            borderLayer.path = rectShape.path // Reuse the Bezier path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.white.cgColor
            borderLayer.lineWidth = 3
            borderLayer.frame = view.bounds
            view.layer.addSublayer(borderLayer)
            view.layer.mask = rectShape
            break
            
        default:
            break
        
        }
        
    }

}
