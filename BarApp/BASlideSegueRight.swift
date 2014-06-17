//
//  BASlideSegue.swift
//  BarApp
//
//  Created by them on 6/10/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BASlideSegueRight: UIStoryboardSegue {
    override func perform() {
        let sVC: UIViewController = self.sourceViewController as UIViewController
        let dVC: UIViewController = self.destinationViewController as UIViewController
        let sourceFrame = sVC.view.frame
        dVC.view.frame = CGRectMake(sourceFrame.minX-sourceFrame.width, sourceFrame.minY, sourceFrame.width, sourceFrame.height)
        let destFrame = CGRectMake(sourceFrame.maxX, sourceFrame.minY, sourceFrame.width, sourceFrame.height)
        sVC.view.addSubview(dVC.view)
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            sVC.view.frame = destFrame
            }, completion: {
                (finished: Bool) in
                dVC.view.removeFromSuperview()
                sVC.presentViewController(dVC, animated: false, completion: nil)
            });
    }
}
