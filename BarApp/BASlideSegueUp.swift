//
//  BASlideSegueVert.swift
//  BarApp
//
//  Created by them on 6/16/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BASlideSegueUp: UIStoryboardSegue {
    override func perform() {
        let sVC: UIViewController = self.sourceViewController as UIViewController
        let dVC: UIViewController = self.destinationViewController as UIViewController
        
        sVC.presentViewController(dVC, animated: false, completion: nil)
        dVC.view.addSubview(sVC.view)
        
        let sourceFrame = dVC.view.frame
        dVC.view.frame = CGRectMake(sourceFrame.minX, sourceFrame.minY, sourceFrame.width, sourceFrame.height)
        let destFrame = CGRectMake(sourceFrame.minX, sourceFrame.minY-sourceFrame.height, sourceFrame.width, sourceFrame.height)
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            sVC.view.frame = destFrame
            }, completion: {
                (finished: Bool) in
                sVC.view.removeFromSuperview()
                //sVC.presentViewController(dVC, animated: false, completion: nil)
            });
    }
}