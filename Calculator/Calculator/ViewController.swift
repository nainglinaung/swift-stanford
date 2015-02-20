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
    
    var brain = CalculatorBrain()
    
    @IBAction func AnyKey(sender: UIButton) {
        let number = sender.currentTitle!
        
        if(userTypedIsOrNot) {
            Answer.text = Answer.text! + number
        } else {
            Answer.text = number
            userTypedIsOrNot = true
        }
    }
    
    
    @IBAction func enter() {
        userTypedIsOrNot = false
        if let result =  brain.pushOperend(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
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
        if userTypedIsOrNot {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0 
            }
        }
        
    }
    
}

