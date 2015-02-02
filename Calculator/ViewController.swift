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
    var userTypedIsOrNot: Bool = false

    @IBAction func AnyKey(sender: UIButton) {
        let number = sender.currentTitle!;
        println("Digit is \(number)")
        
        if(userTypedIsOrNot) {
            Answer.text = Answer.text! + number
        } else {
            Answer.text = number
            userTypedIsOrNot = true
        }
    }

}

