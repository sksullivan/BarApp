//
//  BASlideSegueVert.swift
//  BarApp
//
//  Created by them on 6/16/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BASlideSegueDown: UIStoryboardSegue {
    override func perform() {
        println("GOING")
        let sVC: UIViewController = self.sourceViewController as UIViewController
        let dVC: UIViewController = self.destinationViewController as UIViewController
        let sourceFrame = sVC.view.frame
        dVC.view.frame = CGRectMake(sourceFrame.minX, sourceFrame.minY-sourceFrame.height, sourceFrame.width, sourceFrame.height)
        let destFrame = CGRectMake(sourceFrame.minX, sourceFrame.minY, sourceFrame.width, sourceFrame.height)
        sVC.view.addSubview(dVC.view)
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            dVC.view.frame = destFrame
            }, completion: {
                (finished: Bool) in
                dVC.view.removeFromSuperview()
                sVC.presentViewController(dVC, animated: false, completion: nil)
            });
    }
}