//
//  BADrink.swift
//  BarApp
//
//  Created by them on 6/10/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import Foundation

class BADrink {
    var name: String
    var price: Float
    
    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
}

class BABar {
    var name: String
    var locationString: String
    
    init(name: String, loc: String) {
        self.name = name
        self.locationString = loc
    }
}

var apiroot = "http://api.barific.com/"

class BAAPIPath {
    
    class func login() -> String {
        return "\(apiroot)users/login"
    }
    
    class func logout() -> String {
        return "\(apiroot)users/logout"
    }
}