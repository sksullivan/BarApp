//
//  BAProfileVC.swift
//  BarApp
//
//  Created by them on 6/18/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BAProfileViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    var forgotPassFlowCounter: ForgotPassFlowStatus
    var resetPassFlowCounter: ResetPassFlowStatus
    var code: String?
    var oldPwd: String?
    var newPwd: String?
    var apipath: String
    
    enum ForgotPassFlowStatus {
        case INACTIVE;
        case WILL_ENTER_CODE;
        case WILL_ENTER_CODE_FROM_ERR;
        case WILL_ENTER_NEWPASS;
        case WILL_FINISH;
    }
    
    enum ResetPassFlowStatus {
        case INACTIVE;
        case WILL_ENTER_OLDPASS;
        case WILL_ENTER_OLDPASS_FROM_ERR;
        case WILL_ENTER_NEWPASS;
        case WILL_FINISH;
    }
    
    init(coder aDecoder: NSCoder!) {
        forgotPassFlowCounter = ForgotPassFlowStatus.INACTIVE
        resetPassFlowCounter = ResetPassFlowStatus.INACTIVE
        apipath = (UIApplication.sharedApplication().delegate as AppDelegate).store!.apipath
        super.init(coder: aDecoder)
    }
    
    @IBAction
    func logout() {
        BAUtilREST.request("\(apipath)api/users/logout", method:"POST", bodyString:"session_id=\((UIApplication.sharedApplication().delegate as AppDelegate).store!.sessionID)", callback: {
            (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
            let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println(dataString)
            self.navigationController.setToolbarHidden(true, animated: false)
            self.navigationController.navigationBarHidden = true
            self.navigationController.popToRootViewControllerAnimated(true)
            })
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        println("\(forgotPassFlowCounter == ForgotPassFlowStatus.WILL_ENTER_NEWPASS)")
        if buttonIndex == 0 {
            if forgotPassFlowCounter == ForgotPassFlowStatus.WILL_ENTER_CODE {
                //get code, ask for new pwd
                forgotPassFlowCounter = ForgotPassFlowStatus.WILL_ENTER_NEWPASS
                code = alertView.textFieldAtIndex(0).text
                let alert = UIAlertView()
                alert.title = "Password Reset"
                alert.message = "Please enter your new password twice."
                alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                alert.addButtonWithTitle("OK")
                alert.addButtonWithTitle("Cancel")
                alert.delegate = self
                alert.show()
            } else if forgotPassFlowCounter == ForgotPassFlowStatus.WILL_ENTER_NEWPASS {
                if alertView.textFieldAtIndex(0).text == "" || alertView.textFieldAtIndex(0).text != alertView.textFieldAtIndex(1).text {
                    forgotPassFlowCounter = ForgotPassFlowStatus.WILL_ENTER_CODE_FROM_ERR
                    let alert = UIAlertView()
                    alert.title = "Password Reset"
                    alert.message = "Please re-enter your new password."
                    alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                    alert.addButtonWithTitle("OK")
                    alert.addButtonWithTitle("Cancel")
                    alert.delegate = self
                    alert.show()
                    return
                }
                newPwd = alertView.textFieldAtIndex(0).text
                BAUtilREST.request("\(apipath)api/users/resetPasswordWithCode", method:"POST", bodyString:"token=\(code!)&newpwd=\(newPwd!)", callback: {
                    (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                    let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println(dataString)
                    if dataString == "Great Success" {
                        self.forgotPassFlowCounter = ForgotPassFlowStatus.WILL_FINISH
                        let alert = UIAlertView()
                        alert.title = "Password Reset"
                        alert.message = "Password reset!"
                        alert.alertViewStyle = UIAlertViewStyle.Default
                        alert.addButtonWithTitle("OK")
                        alert.delegate = self
                        alert.show()
                    } else {
                        self.forgotPassFlowCounter = ForgotPassFlowStatus.WILL_ENTER_CODE_FROM_ERR
                        let alert = UIAlertView()
                        alert.title = "Password Reset"
                        alert.message = "Your password reset code was wrong."
                        alert.alertViewStyle = UIAlertViewStyle.Default
                        alert.addButtonWithTitle("OK")
                        alert.addButtonWithTitle("Cancel")
                        alert.delegate = self
                        alert.show()
                    }
                })
            } else if forgotPassFlowCounter == ForgotPassFlowStatus.WILL_ENTER_CODE_FROM_ERR {
                //don't get code, just ask for new pass
                forgotPassFlowCounter = ForgotPassFlowStatus.WILL_ENTER_NEWPASS
                let alert = UIAlertView()
                alert.title = "Password Reset"
                alert.message = "Please re-enter your new password twice."
                alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                alert.addButtonWithTitle("OK")
                alert.addButtonWithTitle("Cancel")
                alert.delegate = self
                alert.show()
            } else if forgotPassFlowCounter == ForgotPassFlowStatus.WILL_FINISH {
                forgotPassFlowCounter == ForgotPassFlowStatus.INACTIVE
                
    //----------------------------------------------------------------------------------------------
                
            } else if resetPassFlowCounter == ResetPassFlowStatus.WILL_ENTER_OLDPASS {
                //get old pass, ask for new pass
                resetPassFlowCounter = ResetPassFlowStatus.WILL_ENTER_NEWPASS
                oldPwd = alertView.textFieldAtIndex(0).text
                let alert = UIAlertView()
                alert.title = "Password Reset"
                alert.message = "Please enter your new password twice."
                alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                alert.addButtonWithTitle("OK")
                alert.addButtonWithTitle("Cancel")
                alert.delegate = self
                alert.show()
            } else if resetPassFlowCounter == ResetPassFlowStatus.WILL_ENTER_NEWPASS {
                //validate new passwords, get new pass, hit up server, display based on result
                if alertView.textFieldAtIndex(0).text == "" || alertView.textFieldAtIndex(0).text != alertView.textFieldAtIndex(1).text {
                    resetPassFlowCounter = ResetPassFlowStatus.WILL_ENTER_OLDPASS_FROM_ERR
                    let alert = UIAlertView()
                    alert.title = "Password Reset"
                    alert.message = "Please re-enter your new password."
                    alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                    alert.addButtonWithTitle("OK")
                    alert.addButtonWithTitle("Cancel")
                    alert.delegate = self
                    alert.show()
                    return
                }
                newPwd = alertView.textFieldAtIndex(0).text
                let username = (UIApplication.sharedApplication().delegate as AppDelegate).store!.username
                BAUtilREST.request("\(apipath)api/users/resetPasswordWithPass?username=\(username)&oldpwd=\(oldPwd!)&newpwd=\(newPwd!)", method:"POST", bodyString:"", callback: {
                        (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                        let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println(dataString)
                        if dataString == "Great Success" {
                            //display good, status = will finish
                            self.resetPassFlowCounter = ResetPassFlowStatus.WILL_FINISH
                            let alert = UIAlertView()
                            alert.title = "Password Reset"
                            alert.message = "Password reset!"
                            alert.alertViewStyle = UIAlertViewStyle.Default
                            alert.addButtonWithTitle("OK")
                            alert.delegate = self
                            alert.show()
                        } else {
                            self.resetPassFlowCounter = ResetPassFlowStatus.WILL_ENTER_OLDPASS
                            let alert = UIAlertView()
                            alert.title = "Password Reset"
                            alert.message = "Your old password was wrong, please re-enter it."
                            alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
                            alert.addButtonWithTitle("OK")
                            alert.addButtonWithTitle("Cancel")
                            alert.delegate = self
                            alert.show()
                        }
                    }
                )
            } else if resetPassFlowCounter == ResetPassFlowStatus.WILL_FINISH {
                resetPassFlowCounter = ResetPassFlowStatus.INACTIVE
            } else if resetPassFlowCounter == ResetPassFlowStatus.WILL_ENTER_OLDPASS_FROM_ERR {
                //just ask for new pass
                let alert = UIAlertView()
                alert.title = "Password Reset"
                alert.message = "Please re-enter your new password twice."
                alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                alert.addButtonWithTitle("OK")
                alert.addButtonWithTitle("Cancel")
                alert.delegate = self
                alert.show()
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction
    func resetPassword() {
        resetPassFlowCounter == ResetPassFlowStatus.WILL_ENTER_OLDPASS
        
        let alert = UIAlertView()
        alert.title = "Password Reset"
        alert.message = "Please enter your current password."
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Cancel")
        alert.delegate = self
        alert.show()
    }
    
    @IBAction
    func forgotPassword() {
        forgotPassFlowCounter == ForgotPassFlowStatus.WILL_ENTER_CODE
        let username = (UIApplication.sharedApplication().delegate as AppDelegate).store!.username
        BAUtilREST.request("\(apipath)api/users/reqPassReset?username=\(username)", method:"GET", bodyString:"", callback: {
                (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(dataString)
                let alert = UIAlertView()
                alert.title = "Password Reset"
                alert.message = "Please enter the code from your email."
                alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
                alert.addButtonWithTitle("OK")
                alert.addButtonWithTitle("Cancel")
                alert.delegate = self
                alert.show()
            }
        )
    }
}
