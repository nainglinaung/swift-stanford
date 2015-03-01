//
//  DiagnosticHappinessViewController.swift
//  Psychologist
//
//  Created by Naing Lin Aung on 3/1/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit


class DiagnosticHappinessViewController: HappinessViewController
{
    var diagnosticHistory = [Int]()
    
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    
    private struct History {
        static let segueIdentifier = "Show Diagnostic History"
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.segueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    tvc.text = "\(diagnosticHistory)"
                }
            default:break
            }
        }
    }
    
    
}
