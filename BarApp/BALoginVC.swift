//
//  BALoginViewController.swift
//  BarApp
//
//  Created by them on 6/8/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BALoginViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var passwordField: UITextField
    @IBOutlet var usernameField: UITextField
    @IBOutlet var errLabel: UILabel
    @IBOutlet var actIndicator: UIActivityIndicatorView
    
    init(coder aDecoder: NSCoder!) {
        (UIApplication.sharedApplication().delegate as AppDelegate).store = BAStore()
        super.init(coder: aDecoder)
    }
    
    func login () {
        println(usernameField)
        println((usernameField as UITextField).text)
        if usernameField.text != "" && passwordField.text != "" {
            errLabel.hidden = true
            actIndicator.hidden = false
            actIndicator.startAnimating()
            
            println("\(BAAPIPath.login())")
            println("username=\(usernameField.text)&password=\(passwordField.text)")
            BAUtilREST.request("\(BAAPIPath.login())", method:"POST", bodyString:"username=\(usernameField!.text)&password=\(passwordField!.text)", callback: {
                (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Data was \(dataString)")
                if (dataString == "No Access") {
                    let alert = UIAlertView()
                    alert.message = "Please double check your username and password."
                    alert.addButtonWithTitle("OK")
                    alert.delegate = self
                    alert.show()
                    self.actIndicator.stopAnimating()
                } else {
                    (UIApplication.sharedApplication().delegate as AppDelegate).store = BAStore()
                    let respDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    println("\(respDict)")
                    (UIApplication.sharedApplication().delegate as AppDelegate).store!.sessionID = respDict["session_id"] as String
                    (UIApplication.sharedApplication().delegate as AppDelegate).store!.customerID = respDict["customer_id"] as String
                    (UIApplication.sharedApplication().delegate as AppDelegate).store!.username = self.usernameField.text
                    self.actIndicator!.stopAnimating()
                    self.performSegueWithIdentifier("moveToBarSelect", sender: self)
                }
            })
        } else {
            UIView.transitionWithView(errLabel, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: nil, completion: nil)
            errLabel.hidden = false
        }
    }
    
    override func viewDidLoad () {
        navigationController.setToolbarHidden(true, animated: false)
        navigationController.navigationBarHidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            //login()
            println(passwordField.text)
            passwordField.resignFirstResponder()
        }
        return true
    }
}
