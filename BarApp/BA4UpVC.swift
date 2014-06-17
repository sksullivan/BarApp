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
    
    enum VCType {
        case Left
        case Right
    }
    var type: VCType?
    
    @IBAction func doSegue(sender: AnyObject?) {
        let sendingGR = sender as? UISwipeGestureRecognizer
        if type == VCType.Left && sender!.direction.value == 2 {
            performSegueWithIdentifier("4to2Left", sender: sender)
        } else if type == VCType.Left && sender!.direction.value == 1 {
            performSegueWithIdentifier("4toLRight", sender: sender)
        } else if type == VCType.Right && sender!.direction.value == 2 {
            performSegueWithIdentifier("4toLLeft", sender: sender)
        } else {
            performSegueWithIdentifier("4to2Right", sender: sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type! == VCType.Left {
            tlButton!.setTitle("Left!", forState: UIControlState.Normal)
        } else {
            tlButton!.setTitle("Right!", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

