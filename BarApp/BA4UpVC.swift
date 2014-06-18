//
//  SecondViewController.swift
//  BarApp
//
//  Created by them on 6/7/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BA4UpViewController: UIViewController {
    
    @IBOutlet var tlButton: UIButton?
    @IBOutlet var trButton: UIButton?
    @IBOutlet var blButton: UIButton?
    @IBOutlet var brButton: UIButton?
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu() {
        navigationController.pushViewController(storyboard.instantiateViewControllerWithIdentifier("BACartVC") as UIViewController, animated: true)
    }
}

