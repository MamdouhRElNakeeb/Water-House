//
//  Splash.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/29/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class Splash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        perform(#selector(showVC), with: nil, afterDelay: 2)
    }
    
    func showVC()  {
        if UserDefaults.standard.bool(forKey: "Login") {
            
            let mainVC =  self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.present(mainVC, animated: true, completion: nil)
            
        }
        else{
            
            //performSegue(withIdentifier: "Main", sender: self)
            
            let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
            self.present(loginVC, animated: true, completion: nil)

            
        }
        
    }

}
