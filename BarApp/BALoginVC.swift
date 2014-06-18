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
    @IBOutlet var registerTextButton: UIButton?
    @IBOutlet var registerPlusButton: UIButton?
    
    @IBAction func login () {
        if uField!.text != "" && pField!.text != "" {
            println("\(uField!.text) + \(pField!.text)")
            registerPlusButton!.hidden = true
            registerTextButton!.hidden = true
            actIndicator!.hidden = false
            actIndicator!.startAnimating()
            BAUtilREST.request("http://dev.barific.com/api/user/login", callback: {
                (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(dataString)
                if (dataString == "Forbidden***") {
                    var device : UIDevice = UIDevice.currentDevice()!;
                    var systemVersion = device.systemVersion;
                    var iosVerion : Float = systemVersion.bridgeToObjectiveC().floatValue;
                    if (iosVerion < 8.0) {
                        let alert = UIAlertView(title: "Problem...", message: "Please double check your username and password.", delegate: self, cancelButtonTitle: nil)
                        alert.show()
                    } else {
                        /*let alert = UIAlertController(title: "Problem...", message: "Please double check your username and password.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)*/
                    }
                    
                } else {
                    self.actIndicator!.hidden = true
                    self.performSegueWithIdentifier("moveToMain", sender: self)
                    (UIApplication.sharedApplication().delegate as AppDelegate).store = BAStore()
                }
            })
        } else {
            UIView.transitionWithView(errLabel, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: nil, completion: nil)
            errLabel!.hidden = false
        }
    }
    
    override func viewDidLoad () {
        println("LOADED")
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
