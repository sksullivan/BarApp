//
//
//  File.swift
//  BarApp
//
//  Created by them on 7/1/14.
//  Copyright (c) 2014 sks. All rights reserved.
//

import UIKit

class BAAddCCViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var creditCardNumberField: UITextField?
    @IBOutlet var expirationMonthField: UITextField?
    @IBOutlet var expirationYearField: UITextField?
    @IBOutlet var ccvCodeField: UITextField?
    @IBOutlet var datePickerButton: UIButton?
    @IBOutlet var datePicker: UIPickerView?
    
    let daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    var selectedMonth: Int!
    //var selectedDay
    
    override func viewDidLoad() {
        selectedMonth = 0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 12
        } else {
            return daysInMonth[selectedMonth!]
        }
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        let rowProxy = row
        if component == 0 {
            let rowProxy = row
            return months[rowProxy]
        } else {
            return String(row)
        }
    }
    
    /*func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        if component
    }*/

    /*@IBAction func pickDate() {
        datePicker!.hidden = false
    }*/
    
    
}
