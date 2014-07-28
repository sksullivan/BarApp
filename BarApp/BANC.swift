//
//  BANC.swift
//  BarApp
//
//  Created by them on 6/17/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BANavigationController: UINavigationController {
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        setToolbarHidden(false, animated: false)
        (UIApplication.sharedApplication().delegate as AppDelegate).store = BAStore()
    }
}
