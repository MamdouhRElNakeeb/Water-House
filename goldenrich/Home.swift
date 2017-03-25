//
//  Home.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/23/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var lastOrdersView: UIView!
    @IBOutlet weak var aboutUsView: UIView!
    @IBOutlet weak var contactUsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roundViewCorners(view: productsView)
        roundViewCorners(view: lastOrdersView)
        roundViewCorners(view: aboutUsView)
        roundViewCorners(view: contactUsView)
    }

    
    func roundViewCorners(view: UIView){
        
        let maskPath = UIBezierPath(rect: CGRect(x: view.layer.position.x, y: view.layer.position.y, width: view.frame.width, height: view.frame.height))
        let layer = CAShapeLayer()
        layer.path = maskPath.cgPath
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.lightGray.cgColor
        
        self.view.layer.addSublayer(layer)
        
    }

}
