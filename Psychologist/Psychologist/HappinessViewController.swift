//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Naing Lin Aung on 2/19/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 10 {
        // 0 is very sad, 100 is ecstastic
        didSet {
            happiness = min(max(happiness,0),100)
            updateUI()
            println("Happiness is = \(happiness)")
        }
    }
    
    func similinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    private struct Constants {
        static let happinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y/Constants.happinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:break
        }
    }
}
