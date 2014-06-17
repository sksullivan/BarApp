//
//  BANC.swift
//  BarApp
//
//  Created by them on 6/16/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BACartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
}
