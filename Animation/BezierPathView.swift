//
//  BezierPathView.swift
//  Animation
//
//  Created by Naing Lin Aung on 3/16/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class BezierPathView: UIView {

    private var bezierPath = [String:UIBezierPath]()
    
    func setPath(path: UIBezierPath?,named name:String) {
        bezierPath[name] = path
        setNeedsDisplay()
    }
    
      override func drawRect(rect: CGRect) {
        for (_,path) in bezierPath {
            path.stroke()
        }
   
    }
   
}
