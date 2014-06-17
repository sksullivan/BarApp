//
//  BAStore.swift
//  BarApp
//
//  Created by them on 6/16/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import Foundation

class BAStore {
    var cart: Array<BADrink>
    
    init() {
        cart = []
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