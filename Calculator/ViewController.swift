//
//  ViewController.swift
//  Calculator
//
//  Created by Naing Lin Aung on 2/2/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var Answer: UILabel!
    var userTypedIsOrNot = false

    @IBAction func AnyKey(sender: UIButton) {
        let number = sender.currentTitle!
        
        if(userTypedIsOrNot) {
            Answer.text = Answer.text! + number
        } else {
            Answer.text = number
            userTypedIsOrNot = true
        }
    }
    
    var operendStack = Array<Double>()
    
    @IBAction func enter() {
        userTypedIsOrNot = false
        operendStack.append(displayValue)
        println("Operend is \(operendStack)")
    }
    
    var displayValue:Double {
        set{
           Answer.text = "\(newValue)"
           userTypedIsOrNot = false
        }
        get{
          return NSNumberFormatter().numberFromString(Answer.text!)!.doubleValue
        }
    }

    
   
    
    
    @IBAction func performOperation(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
            case "+": performOperation { $0 + $1 }
            case "−": performOperation { $1 - $0 }
            case "×": performOperation { $0 * $1}
            case "÷": performOperation { $1 / $0 }
            case "√": performOperation { $0 }
            default:break
        }
        
    }
    
    
    func performOperation(operation: Double -> Double) {
        if operendStack.count >= 1 {
            displayValue = operation(operendStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double,Double) -> Double){
        if operendStack.count >= 2 {
            displayValue = operation(operendStack.removeLast(),operendStack.removeLast())
            enter()
        }
    }

}

