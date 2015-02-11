//
//  ViewController.swift
//  calculator
//
//  Created by Mitchell Tieleman on 08/02/15.
//  Copyright (c) 2015 Mitchell Tieleman. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var MiddleOfTypingNumber = false
    let x = M_PI

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if MiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            MiddleOfTypingNumber = true
        }

    }
 
//code met Double
//case "✕": performOperation( { (op1: Double, op2: Double) -> Double in return op1 * op2 })
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if MiddleOfTypingNumber {
            enter()
        }
        switch operation {
        case "✕": performOperation {$0 * $1}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$0 + $1}
        case "-": performOperation {$1 - $0}
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default: break
        }
    }
    
    func performOperation (operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast() ,operandStack.removeLast())
            enter()
        }
    }

    func performOperation (operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func pi() {
        MiddleOfTypingNumber = true
        if display.text != "0" {
            enter()
            display.text = "\(x)"
            enter()
        } else {
            display.text = "\(x)"
            enter()
        }
    }
    
    @IBAction func clear() {
        MiddleOfTypingNumber = false
        operandStack.removeAll()
        display.text = "0"
        enter()
    }

    
    
    var decimalIsPressed = false
    @IBAction func decimal() {
        MiddleOfTypingNumber = true
        if decimalIsPressed == false {
            display.text = display.text! + "."
            decimalIsPressed = true
        }
    }
    
//    func multiply(op1: Double, op2: Double) -> Double {
//        return op1 * op2
//    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        MiddleOfTypingNumber = false
        operandStack.append(displayValue)
        decimalIsPressed = false
        history.text = "\(displayValue)"
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            MiddleOfTypingNumber = false
        }
    }
    
}

