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
    class func request(url:String, method: String, bodyString: String, callback:(NSURLResponse!, NSData!, NSError!) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url))
        request.addValue("KGj9IJKylSJTdk4G2YH1ID6ykR2Xpb0q", forHTTPHeaderField:"apikey");
        request.HTTPMethod = method
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        let postData = (bodyString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: callback)
    }
}