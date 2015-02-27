//
//  ViewController.swift
//  Psychologist
//
//  Created by Naing Lin Aung on 2/27/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destination =  segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
    
        
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "sad": hvc.happiness  = 0
                    case "happy": hvc.happiness = 100
                    case "Nothing" : hvc.happiness = 25
                    default : hvc.happiness = 50
                }
            }
        }
    }
    @IBAction func Nothing(sender: UIButton) {
        performSegueWithIdentifier("Nothing", sender: nil)
        
    }

}

