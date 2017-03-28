//
//  AboutUs.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class AboutUs: UITableViewController {
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "ic_login_bg.jpg"))
        self.tableView.backgroundColor = UIColor.clear
    }
   
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear

    }
    
    
}
