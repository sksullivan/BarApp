//
//  File.swift
//  BarApp
//
//  Created by them on 6/30/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BABarSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var barArray: Array<BABar>
    
    init(coder aDecoder: NSCoder!) {
        let joes = BABar(name: "Joe's", loc: "Nowhere")
        let redLion = BABar(name: "Red Lion", loc: "Here")
        let kams = BABar(name: "Kam's", loc: "Who knows where")
        barArray = [joes,redLion,kams]
        
        super.init(coder: aDecoder)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        println(indexPath.row)
        let simpleTableIdentifier = "bti";
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        
        var bar = barArray[indexPath.row]
        cell!.textLabel.text = bar.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedBar = barArray[indexPath.row]
        var device : UIDevice = UIDevice.currentDevice()!;
        var systemVersion = device.systemVersion;
        var iosVersion : Float = systemVersion.bridgeToObjectiveC().floatValue;
        if (iosVersion < 8.0) {
            let alert = UIAlertView()
            alert.title = "You sure you're at \(selectedBar.name)?"
            alert.addButtonWithTitle("Yes!")
            alert.addButtonWithTitle("No")
            alert.delegate = self
            alert.show()
        } else {
            let alert = UIAlertController(title: "You sure you're at \(selectedBar.name)?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Yes!", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}