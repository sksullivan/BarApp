//
//  BAUtilREST.swift
//  BarApp
//
//  Created by them on 6/5/14.
//  Copyright (c) 2014 TeamGriz. All rights reserved.
//

import UIKit
import Foundation

class BAUtilREST {
    class func request(url:String, callback:(NSURLResponse!, NSData!, NSError!) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: callback)
    }
}