//
//  ContactUs.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/27/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import GoogleMaps

class ContactUs: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapUIView: GMSMapView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var fbBtn: UIView!
    @IBOutlet weak var callBtn: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: 30.074795, longitude: 31.302060, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        
        mapUIView.camera = camera
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 30.074795, longitude: 31.302060)
        marker.title = "Golden Rich Company"
        marker.map = mapUIView
        
        let fbBtnTap = UITapGestureRecognizer(target: self, action: #selector(fbIntent))
        fbBtnTap.delegate = self
        let callBtnTap = UITapGestureRecognizer(target: self, action: #selector(callIntent))
        callBtnTap.delegate = self
        fbBtn.addGestureRecognizer(fbBtnTap)
        callBtn.addGestureRecognizer(callBtnTap)
        

    }
    
    func fbIntent() {
        UIApplication.tryURL(urls: [
            "fb://profile/siwawater", // App
            "http://www.facebook.com/siwawater" // Website if app fails
            ])
    }
    
    func callIntent() {
        guard let number = URL(string: "tel://19409") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
}


extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(NSURL(string: url)! as URL) {
                application.open(URL(string: url)!, options: [:], completionHandler: nil)
                return
            }
        }
    }
}




