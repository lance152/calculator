//
//  ViewController.swift
//  calculator
//
//  Created by Lance Fan on 16/6/29.
//  Copyright © 2016年 Lance Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var isUserInMiddleOfTyping = false
    
    var brain = CalculatorBrain()
    
    @IBAction func operate(sender: UIButton) {
        
        if isUserInMiddleOfTyping{
            enter()
        }
        
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserInMiddleOfTyping{
            display.text = display.text! + digit
        }else{
            display.text = digit
            isUserInMiddleOfTyping=true
        }
    }
    
    @IBAction func enter() {
        isUserInMiddleOfTyping=false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set{
            display.text = "\(newValue)"
            isUserInMiddleOfTyping=false
        }
    }
    
}

