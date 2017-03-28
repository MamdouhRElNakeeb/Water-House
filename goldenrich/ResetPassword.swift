//
//  ResetPassword.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/23/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Alamofire
import UIKit

class ResetPassword: UIViewController, UITextFieldDelegate {

    //Defined a constant that holds the URL for our web service
    let URL_USER_REGISTER = "http://apps.be4em.net/goldenrich/API/users/resetpassword"

    @IBOutlet weak var emailTxtField: UITextField!
    
    var progressBar: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTxtField.delegate = self
    }

    
    @IBAction func backBtnOnClick(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtnOnClick(_ sender: AnyObject) {
        if (emailTxtField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Email is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        showProgressBar()
        //creating parameters for the post request
        let parameters: Parameters=[
            "email":emailTxtField.text!
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                self.hideProgressBar()
                
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData["mesasage"])
                    print(jsonData.value(forKey: "mesasage"))
                    let code = jsonData.value(forKey: "code") as! Int
                    
                    if code == 500{
                    
                        //displaying the message in label
                        
                            
                        //let errMsgArray : NSArray = (jsonData.value(forKey: "mesasage") as? NSArray)!
                        
                        let alert = UIAlertController(title: "Forget Password", message: jsonData.value(forKey: "mesasage") /*errMsgArray.firstObject*/ as! String?, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default))
                        self.present(alert, animated: true, completion: nil)
                        return

                    }
                    else if code == 200{
                        
                        //displaying the message in Alert
                        
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
                            UIAlertAction in
                            self.dismiss(animated: true, completion: nil)
                        }
                        let alert = UIAlertController(title: "Forget Password", message: "Your password has been sent successfully", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
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
    
    func dismissController() {
        
    }

}
