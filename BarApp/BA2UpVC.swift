//
//  FirstViewController.swift
//  BarApp
//
//  Created by them on 6/7/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BA2UpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let gestureRecognizer = sender as UISwipeGestureRecognizer
        println(gestureRecognizer.direction.value)
        if gestureRecognizer.direction.value == 1 {
            let target = segue.destinationViewController as BA4UpViewController
            target.type = BA4UpViewController.VCType.Left
        } else if gestureRecognizer.direction.value == 2 {
            let target = segue.destinationViewController as BA4UpViewController
            target.type = BA4UpViewController.VCType.Right
        }
    }
}

