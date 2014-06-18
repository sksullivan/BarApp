//
//  BANC.swift
//  BarApp
//
//  Created by them on 6/16/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BACartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    
    override func viewDidLoad() {
        var items: Array<UIBarButtonItem> = []
        let item1 = UIBarButtonItem(title: "Order!", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showConfirm"))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let item2 = UIBarButtonItem(title: "Profile", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showProfile"))
        items.append(item1)
        items.append(spacer)
        items.append(item2)
        setToolbarItems(items, animated: false)
        navigationController.setToolbarHidden(false, animated: false)
        navigationController.navigationBarHidden = false
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        (UIApplication.sharedApplication().delegate as AppDelegate).store!.removeItemFromCart(indexPath.row)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as AppDelegate).store!.cart.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        println(indexPath.row)
        let simpleTableIdentifier = "sti";
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        
        var drink: BADrink
        drink = (UIApplication.sharedApplication().delegate as AppDelegate).store!.cart[indexPath.row]
        cell!.textLabel.text = drink.name
        return cell
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            println("Placed")
        } else {
            println("cancled")
        }
    }
    
    func showProfile() {
        navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BAProfileVC") as UIViewController, animated: true)
    }
    
    func showConfirm() {
        var device : UIDevice = UIDevice.currentDevice()!;
        var systemVersion = device.systemVersion;
        var iosVersion : Float = systemVersion.bridgeToObjectiveC().floatValue;
        println(iosVersion)
        if (iosVersion < 8.0) {
            let alert = UIAlertView()
            alert.title = "Place order?"
            alert.addButtonWithTitle("OK")
            alert.addButtonWithTitle("Cancel")
            alert.delegate = self
            alert.show()
        } else {
            let alert = UIAlertController(title: "Place order?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
