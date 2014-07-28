//
//  File.swift
//  BarApp
//
//  Created by them on 6/30/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BABarSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    
    var selectedBarNum: Int?
    var barList: Array<BABar>
    
    init(coder aDecoder: NSCoder!) {
        self.barList = (UIApplication.sharedApplication().delegate as AppDelegate).store!.barList
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return barList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        println(indexPath.row)
        let simpleTableIdentifier = "bti";
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        
        var bar = barList[indexPath.row]
        cell!.textLabel.text = bar.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedBar = barList[indexPath.row]
        selectedBarNum = indexPath.row
        let alert = UIAlertView()
        alert.title = "You sure you're at \(selectedBar.name)?"
        alert.addButtonWithTitle("Yes!")
        alert.addButtonWithTitle("No")
        alert.delegate = self
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            println("NSDLKGJHSDLKG")
            (UIApplication.sharedApplication().delegate as AppDelegate).store!.setCurrentBar(selectedBarNum!)
            presentViewController(storyboard.instantiateViewControllerWithIdentifier("BA2UpVC") as BA2UpViewController, animated: true, completion: nil)
        }
    }
}