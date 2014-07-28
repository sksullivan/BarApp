//
//  FirstViewController.swift
//  BarApp
//
//  Created by them on 6/7/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BA2UpViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet var navItem: UINavigationItem?
    @IBOutlet var topButton: UIButton?
    @IBOutlet var bottomButton: UIButton?
    let drinksList: Array<BADrink>
    var selectedDrink: Int?
    
    init(coder aDecoder: NSCoder!) {
        drinksList = (UIApplication.sharedApplication().delegate as AppDelegate).store!.getTopTwo()
        println("\(drinksList)")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("\(drinksList.count)")
        navItem!.rightBarButtonItem = UIBarButtonItem(title: "More", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMoreDrinks"))
        var items: Array<UIBarButtonItem> = []
        let item = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMenu"))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.append(spacer)
        items.append(item)
        items.append(spacer)
        setToolbarItems(items, animated: false)
        navigationController.setToolbarHidden(false, animated: false)
        navigationController.navigationBarHidden = false
        
        topButton!.setTitle(drinksList[0].name, forState: UIControlState.Normal)
        bottomButton!.setTitle(drinksList[1].name, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickedDrink(sender: AnyObject) {
        var theSender = sender as UIButton
        if theSender == topButton {
            selectedDrink = 0;
        } else {
            selectedDrink = 1;
        }
        let alert = UIAlertView()
        alert.title = "Add \(theSender.titleLabel.text) to cart?"
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Cancel")
        alert.delegate = self
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            (UIApplication.sharedApplication().delegate as AppDelegate).store!.addItemToCart(drinksList[selectedDrink!])
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).store!.printCart()
    }
    
    func showMoreDrinks() {
       navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BA4UpVC") as UIViewController, animated: true)
    }
    
    func showMenu() {
        navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BACartVC") as UIViewController, animated: true)
    }
}

