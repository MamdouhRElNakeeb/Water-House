//
//  Splash.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/29/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class Splash: UIViewController {

    @IBOutlet weak var splashProgreesView: UIProgressView!
    
    var count : Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        splashProgreesView.setProgress(0, animated: true)
        splashProgreesView.progress = 0
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }
    
    func showVC()  {
        if UserDefaults.standard.bool(forKey: "Login") {
            
            let mainVC =  self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.present(mainVC, animated: true, completion: nil)
            
        }
        else{
            
            
            
            let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
            self.present(loginVC, animated: true, completion: nil)

            
        }
        
    }
    
    func update() {
        if(count > 0) {
            splashProgreesView.setProgress(Float(count), animated: true)
            count -= 1
        }
        else{
            showVC()
        }
    }

}
