//
//  FirstViewController.swift
//  BarApp
//
//  Created by them on 6/7/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BA2UpViewController: UIViewController {
    
    @IBOutlet var navItem: UINavigationItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMoreDrinks"))
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMoreDrinks() {
       navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BA4UpVC") as UIViewController, animated: true)
    }
    
    func showMenu() {
        navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BACartVC") as UIViewController, animated: true)
    }
}

