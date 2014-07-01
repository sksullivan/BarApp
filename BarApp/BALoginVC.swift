//
//  BALoginViewController.swift
//  BarApp
//
//  Created by them on 6/8/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BALoginViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var uField: UITextField?
    @IBOutlet var pField: UITextField?
    @IBOutlet var errLabel: UILabel?
    @IBOutlet var actIndicator: UIActivityIndicatorView?
    let apipath: String
    
    init(coder aDecoder: NSCoder!) {
        (UIApplication.sharedApplication().delegate as AppDelegate).store = BAStore()
        apipath = (UIApplication.sharedApplication().delegate as AppDelegate).store!.apipath
        super.init(coder: aDecoder)
    }
    
    func login () {
        if uField!.text != "" && pField!.text != "" {
            actIndicator!.hidden = false
            actIndicator!.startAnimating()
            println("\(apipath)api/users/login")
            println("username=\(uField!.text)&password=\(pField!.text)")
            BAUtilREST.request("\(apipath)api/users/login", method:"POST", bodyString:"username=\(uField!.text)&password=\(pField!.text)", callback: {
                (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Data was \(dataString)")
                if (dataString == "No Access") {
                    var device : UIDevice = UIDevice.currentDevice()!;
                    var systemVersion = device.systemVersion;
                    var iosVerion : Float = systemVersion.bridgeToObjectiveC().floatValue;
                    if (iosVerion < 8.0) {
                        let alert = UIAlertView()
                        alert.message = "Please double check your username and password."
                        alert.addButtonWithTitle("OK")
                        alert.delegate = self
                        alert.show()
                        self.actIndicator!.stopAnimating()
                    } else {
                        let alert = UIAlertController(title: nil, message: "Please double check your username and password.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        self.actIndicator!.stopAnimating()
                    }
                } else {
                    let respDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    println("\(respDict)")
                    (UIApplication.sharedApplication().delegate as AppDelegate).store!.sessionID = respDict["session_id"] as String
                    (UIApplication.sharedApplication().delegate as AppDelegate).store!.customerID = respDict["customer_id"] as String
                    (UIApplication.sharedApplication().delegate as AppDelegate).store!.username = self.uField!.text
                    self.actIndicator!.stopAnimating()
                    self.performSegueWithIdentifier("moveToBarSelect", sender: self)
                }
            })
        } else {
            UIView.transitionWithView(errLabel, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: nil, completion: nil)
            errLabel!.hidden = false
        }
    }
    
    override func viewDidLoad () {
        navigationController.setToolbarHidden(true, animated: false)
        navigationController.navigationBarHidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == uField {
            pField!.becomeFirstResponder()
        } else {
            login()
            pField!.resignFirstResponder()
        }
        return true
    }
}
