//
//  BAStore.swift
//  BarApp
//
//  Created by them on 6/16/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BAStore {
    var cart: Array<BADrink>
    var customerID: String
    var sessionID: String
    var username: String
    let apipath = "http://dev.barific.com/"
    var barList: Array<BABar> = []
    //let apipath = "http://192.168.0.101:3000/"
    
    init() {
        cart = []
        customerID = ""
        sessionID = ""
        username = ""
        BAUtilREST.request("\(apipath)api/bars", method:"GET", bodyString:"", callback: {
            (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            let tempBarList = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
            for abar:Dictionary in tempBarList {
                let bar = abar as Dictionary
                self.barList.append(BABar(name: bar.name, loc: bar.loc))
            }
        })
    }
    
    func printCart() {
        for item in cart {
            println(item.name)
        }
    }
    
    func addItemToCart(drink: BADrink) {
        cart.append(drink)
    }
    
    func removeItemFromCart(itemNumber: Int) {
        cart.removeAtIndex(itemNumber)
    }
}