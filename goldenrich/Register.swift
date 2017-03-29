//
//  Register.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/23/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Alamofire
import UIKit

class Register: UIViewController, UITextFieldDelegate {

    //Defined a constant that holds the URL for our web service
    let URL_USER_REGISTER = "http://apps.be4em.net/goldenrich/API/users/create"
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    //@IBOutlet weak var registerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
        nameTxtField.delegate = self
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        phoneTxtField.delegate = self
        addressTxtField.delegate = self
        
    }

    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @IBAction func backBtnOnClick(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtnOnClick(_ sender: AnyObject) {
        
        if (nameTxtField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Name is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        if (emailTxtField.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Email is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (passwordTxtField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Password is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        if (phoneTxtField.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Phone is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (addressTxtField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Address is missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        //creating parameters for the post request
        let parameters: Parameters=[
            "username":nameTxtField.text!,
            "email":emailTxtField.text!,
            "password":passwordTxtField.text!,
            "phone":phoneTxtField.text!,
            "address":addressTxtField.text!
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    let code = jsonData.value(forKey: "code") as! Int
                    
                    if code == 500{
                        /*
                        do{
                            let errMsg = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary //
                            
                        }
                        catch{
                        }
 */
                        let errMsg = jsonData["mesasage"] as! [[String:String]]
                        let alert = UIAlertController(title: "Error", message: errMsg[0][""], preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                        
                    }
                    else if code == 200{
                        
                        //successfully logged in our user
                        self.dismiss(animated: true, completion: nil)
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
    
    
    
}
