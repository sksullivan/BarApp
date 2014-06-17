//
//  BAListVC.swift
//  BarApp
//
//  Created by them on 6/10/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BAListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate, UIAlertViewDelegate {
    
    var drinksArray: BADrink[]
    var filteredDrinksArray: BADrink[]
    var selectedDrink: BADrink!
    @IBOutlet var tableView: UITableView
    @IBOutlet var searchBar: UISearchBar
    var searching: Bool
    
    init(coder aDecoder: NSCoder!)  {
        searching = false
        let martini = BADrink(name: "Martini", price: 16.00)
        let cosmo = BADrink(name: "Cosmo", price: 32.00)
        let longIsland = BADrink(name: "Long Island", price: 8.00)
        drinksArray = [martini, cosmo, longIsland]
        filteredDrinksArray = BADrink[]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        //(searchBar.valueForKey("_searchField") as UITextField).textColor = UIColor.whiteColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let gestureRecognizer = sender as UISwipeGestureRecognizer
        let target = segue.destinationViewController as BA4UpViewController
        if gestureRecognizer.direction.value == 1 {
            target.type = BA4UpViewController.VCType.Right
        } else {
            target.type = BA4UpViewController.VCType.Left
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return filteredDrinksArray.count < drinksArray.count ? filteredDrinksArray.count : drinksArray.count // Doesn't show array fo all drinks when table loads
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        println(indexPath.row)
        let simpleTableIdentifier = "simpleTableItem";
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        
        var drink: BADrink
        if searching {
            println("loading from search")
            drink = filteredDrinksArray[indexPath.row]
        } else {
            println("loading from norm")
            drink = drinksArray[indexPath.row]
        }
        cell!.textLabel.text = drink.name
        cell!.backgroundColor = UIColor(red: 93/255.0, green: 62/255.0, blue: 26/255.0, alpha: 1.0)
        cell!.textColor = UIColor.whiteColor()
        return cell
    }
    
    func stringContains(one: String, two: String) -> Bool {
        let a: NSString = (NSString(string: one)).lowercaseString
        let b: NSString = (NSString(string: two)).lowercaseString
        var contained = false
        var localContained = true
        if a == "" || b == "" || b.length > a.length {
            return false
        }
        for i in 0 .. a.length {
            if b.characterAtIndex(0) == a.characterAtIndex(i) {
                localContained = true
                let index = i
                for j in i .. i+b.length {
                    if j >= a.length || b.characterAtIndex(j-index) != a.characterAtIndex(j) {
                        localContained = false;
                    }
                }
                if localContained {
                    contained = true
                }
            }
        }
        return contained
    }
    
    func filterContentForSearchText(searchText: String) {
        println(searchText)
        filteredDrinksArray = drinksArray.filter{ self.stringContains($0.name, two: searchText) }
    }
    
    func searchBar(theSearchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView tableView: UITableView) {
        println("SHOWING")
        searching = true
        tableView.reloadData()
    }
    
    func searchDisplayController(controller: UISearchDisplayController, willHideSearchResultsTableView tableView: UITableView) {
        println("HIDING")
        searching = false
        tableView.reloadData()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            (UIApplication.sharedApplication().delegate as AppDelegate).store!.addItemToCart(selectedDrink)
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).store!.printCart()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if searching {
            selectedDrink = filteredDrinksArray[indexPath.row]
        } else {
            selectedDrink = drinksArray[indexPath.row]
        }
        var device : UIDevice = UIDevice.currentDevice()!;
        var systemVersion = device.systemVersion;
        var iosVersion : Float = systemVersion.bridgeToObjectiveC().floatValue;
        println(iosVersion)
        if (iosVersion < 8.0) {
            let alert = UIAlertView()
            alert.title = "Add \(selectedDrink.name) to cart?"
            alert.addButtonWithTitle("OK")
            alert.addButtonWithTitle("Cancel")
            alert.delegate = self
            alert.show()
        } else {
            let alert = UIAlertController(title: "Add \(selectedDrink.name) to cart?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
