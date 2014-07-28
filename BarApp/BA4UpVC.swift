//
//  SecondViewController.swift
//  BarApp
//
//  Created by them on 6/7/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BA4UpViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet var tlButton: UIButton?
    @IBOutlet var trButton: UIButton?
    @IBOutlet var blButton: UIButton?
    @IBOutlet var brButton: UIButton?
    let drinksList: Array<BADrink>
    var selectedDrink: Int?
    
    init(coder aDecoder: NSCoder!) {
        drinksList = (UIApplication.sharedApplication().delegate as AppDelegate).store!.getNextFour()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var items: Array<UIBarButtonItem> = []
        let item = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMenu"))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.append(spacer)
        items.append(item)
        items.append(spacer)
        setToolbarItems(items, animated: false)
        navigationController.setToolbarHidden(false, animated: false)
        navigationController.navigationBarHidden = false
        
        tlButton!.setTitle(drinksList[0].name, forState: UIControlState.Normal)
        trButton!.setTitle(drinksList[1].name, forState: UIControlState.Normal)
        blButton!.setTitle(drinksList[2].name, forState: UIControlState.Normal)
        brButton!.setTitle(drinksList[3].name, forState: UIControlState.Normal)
    }
    
    @IBAction func pickedDrink(sender: AnyObject) {
        var theSender = sender as UIButton
        if theSender == tlButton {
            selectedDrink = 0;
        } else if theSender == trButton {
            selectedDrink = 1;
        } else if theSender == blButton {
            selectedDrink = 2;
        } else {
            selectedDrink = 3;
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu() {
        navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BACartVC") as UIViewController, animated: true)
    }
}

