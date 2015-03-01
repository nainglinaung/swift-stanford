//
//  DiagnosticHappinessViewController.swift
//  Psychologist
//
//  Created by Naing Lin Aung on 3/1/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit


class DiagnosticHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate
{
    
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory:[Int] {
    get { return defaults.objectForKey(History.DefaultKey) as? [Int] ?? []  }
    set { defaults.setObject(newValue,forKey: History.DefaultKey) }
    }
    
    
    //= [Int]()
    
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    
    private struct History {
        static let segueIdentifier = "Show Diagnostic History"
        static let DefaultKey = "diagnosticHappiness"
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.segueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default:break
            }
        }
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
