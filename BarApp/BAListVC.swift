//
//  BAListVC.swift
//  BarApp
//
//  Created by them on 6/10/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BAListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIAlertViewDelegate {
    
    var drinksArray: [BADrink]
    var filteredDrinksArray: [BADrink]
    var selectedDrink: BADrink!
    @IBOutlet var tableView: UITableView
    @IBOutlet var searchBar: UISearchBar
    var searching: Bool
    
    init(coder aDecoder: NSCoder!)  {
        searching = false
        drinksArray = (UIApplication.sharedApplication().delegate as AppDelegate).store!.drinksList
        filteredDrinksArray = [BADrink]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        var items: Array<UIBarButtonItem> = []
        let item = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMenu"))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.append(spacer)
        items.append(item)
        items.append(spacer)
        setToolbarItems(items, animated: false)
        navigationController.setToolbarHidden(false, animated: false)
        navigationController.navigationBarHidden = false
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println(searching ? "counting search =  true" : "counting search =  false")
        if searching {
            return filteredDrinksArray.count
        } else {
            return drinksArray.count
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
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
        for i in 0 ..< a.length {
            if b.characterAtIndex(0) == a.characterAtIndex(i) {
                localContained = true
                let index = i
                for j in i ..< i+b.length {
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
        println("shit changed \(searchText)")
        if searchText == "" {
            searching = false
        } else {
            searching = true
        }
        filterContentForSearchText(searchText)
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
        let alert = UIAlertView()
        alert.title = "Add \(selectedDrink.name) to cart?"
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Cancel")
        alert.delegate = self
        alert.show()
    }
    
    func showMenu() {
        navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BACartVC") as UIViewController, animated: true)
    }
}
