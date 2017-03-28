//
//  Login.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/23/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Alamofire
import UIKit

class Login: UIViewController, UITextFieldDelegate {

    //Defined a constant that holds the URL for our web service
    let URL_USER_REGISTER = "http://apps.be4em.net/goldenrich/API/users/login"
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    var progressBar: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnOnClick(_ sender: AnyObject) {
        
        if (emailTxtField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Email is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        if (passwordTxtField.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Password is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        showProgressBar()
        //creating parameters for the post request
        let parameters: Parameters=[
            "email":emailTxtField.text!,
            "password":passwordTxtField.text!
        ]
        
        /*
        var manager = SessionManager.sharedInstance
        
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
            "Content-Type": "application/json",
            "Accept": "application/json" //Optional
        ]
        */
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters)
            //.validate(contentType: ["application/json"])
            //.validate(contentType: ["application/x-www-form-urlencoded;charset=UTF-8"])
            .responseJSON
            {
                response in
                
                self.hideProgressBar()
                
                //let response = response as! String
                //let res = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                
                //printing response
                /*
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    //print("Data: \(utf8Text)")
                }
                */
                
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    let code = jsonData.value(forKey: "code") as! Int
                    
                    //jsonData.data(using: String.Encoding.utf8)
                    
                    if code == 500{
                        let errMsg = jsonData["mesasage"] as! [[String:String]]
                        let alert = UIAlertController(title: "Error", message: errMsg[0][""], preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    else if code == 200{
                        
                        
                        let dataArray = jsonData.value(forKey: "data") as! NSDictionary
                        let userDataArray = dataArray.value(forKey: "userData") as! NSDictionary
                        
                        print(dataArray.value(forKey: "userData"))
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(userDataArray.value(forKey: "userId"), forKey: "userId")
                        userDefaults.set(userDataArray.value(forKey: "username"), forKey: "username")
                        userDefaults.set(userDataArray.value(forKey: "email"), forKey: "email")
                        userDefaults.set(userDataArray.value(forKey: "phone"), forKey: "phone")
                        userDefaults.set(userDataArray.value(forKey: "address"), forKey: "address")
                        userDefaults.set(userDataArray.value(forKey: "api_token"), forKey: "api_token")
                        userDefaults.synchronize()
                        
                    }
                    
                    //displaying the message in label
                    //print(jsonData.value(forKey: "message") as! String?)
                }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
