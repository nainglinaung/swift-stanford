//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Naing Lin Aung on 2/19/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController
{
    var happiness: Int = 50 {
        // 0 is very sad, 100 is ecstastic
        didSet {
            happiness = min(max(happiness,0),100)
            updateUI()
            println("Happiness is = \(happiness)")
        }
    }
    
    func updateUI() {
        
    }
}
