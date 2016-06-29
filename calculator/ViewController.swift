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
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if isUserInMiddleOfTyping{
            enter()
        }
        switch operation {
        case "×": performOperation{$0 * $1}
        case "÷": performOperation{$1 / $0}
        case "+": performOperation{$1 + $0}
        case "−": performOperation{$1 - $0}
        case "√": performOperation{sqrt($0)}
        default:break
        }
    }
    
    func performOperation (operation: (Double,Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation (operation: Double-> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
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
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        isUserInMiddleOfTyping=false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
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

