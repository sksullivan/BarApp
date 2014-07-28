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
    var barList: Array<BABar>
    var drinksList: Array<BADrink>
    var barNum: Int?
    //let apipath = "http://192.168.0.101:3000/"
    
    init() {
        cart = []
        customerID = ""
        sessionID = ""
        username = ""
        
        //Real Code
        
        /*BAUtilREST.request("\(apipath)api/bars", method:"GET", bodyString:"", callback: {
            (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            let tempBarList = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
        })*/
        
        //Dummy code
        
        let joes = BABar(name: "Joe's", loc: "Nowhere")
        let redLion = BABar(name: "Red Lion", loc: "Here")
        let kams = BABar(name: "Kam's", loc: "Who knows where")
        barList = [joes,redLion,kams]
        
        let martini = BADrink(name: "Martini", price: 16.00)
        let cosmo = BADrink(name: "Cosmo", price: 32.00)
        let longIsland = BADrink(name: "Long Island", price: 2.00)
        let shortIsland = BADrink(name: "Short Island", price: 1.00)
        let water = BADrink(name: "Water", price: 0.00)
        let screwdriver = BADrink(name: "Screwdriver", price: 3.00)
        let irishCoffee = BADrink(name: "Irish Coffee", price: 4.00)
        drinksList = [martini, cosmo, longIsland, shortIsland, water, screwdriver, irishCoffee]
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
    
    func setCurrentBar(barNumber: Int) {
        barNum = barNumber
        
        //Get request to server to get drinks
        
        /*BAUtilREST.request("\(apipath)api/bar_id_909090/drinks", method:"GET", bodyString:"", callback: {
        (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
        let tempBarList = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
        })*/
    }
    
    func getCurrentBar() -> BABar {
        return barList[barNum!]
    }
    
    func getTopTwo() -> Array<BADrink> {
        drinksList.sort({ $0.name > $1.name })
        println("NOW WE ARE: \(Array(drinksList[0..<2]).count)")
        return Array(drinksList[0..<2])
    }
    
    func getNextFour() -> Array<BADrink> {
        func sortAlpha(d1: BADrink, d2: BADrink) -> Bool {
            return d1.name < d2.name
        }
        sort(&drinksList, sortAlpha)
        return Array(drinksList[2..<6])
    }
}