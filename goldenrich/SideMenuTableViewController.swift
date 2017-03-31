//
//  SideMenuTableViewController.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/29/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutBtn: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = UserDefaults.standard.object(forKey: "username") as! String?
        
        let logoutBtnTap = UITapGestureRecognizer(target: self, action: #selector(logout))
        logoutBtnTap.delegate = self.logoutBtn
        logoutBtn.addGestureRecognizer(logoutBtnTap)

    }

    func logout()  {
        UserDefaults.standard.set(false, forKey: "Login")
        let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
        self.present(loginVC, animated: true, completion: nil)
    }
}
