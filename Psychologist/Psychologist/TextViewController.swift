//
//  TextViewController.swift
//  Psychologist
//
//  Created by Naing Lin Aung on 3/1/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class TextViewController: UIViewController
{
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }

    var text: String = "" {
        didSet{
            textView?.text = text
        }
    }
    
}
