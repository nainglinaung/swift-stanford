//
//  FaceView.swift
//  Happiness
//
//  Created by Naing Lin Aung on 2/19/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit


protocol FaceViewDataSource: class {
    func similinessForFaceView(sender: FaceView) -> Double?
}

@IBDesignable

class FaceView: UIView {

    var faceCenter: CGPoint {
        return convertPoint(center, fromView:superview)
    }
    
    @IBInspectable var scale:CGFloat  = 0.9 {didSet { setNeedsDisplay() } }
    @IBInspectable var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor(){ didSet { setNeedsDisplay() } }
    
    weak var dataSource:FaceViewDataSource?
    
    private enum Eye {case Left, Right}
    
    
    
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        

        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth;
        return path
        
    }

    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile,1),-1)) * mouthHeight
        
        let start = CGPoint(x:faceCenter.x - mouthWidth / 2 , y:faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x:start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x:start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x:end.x - mouthWidth/3, y:cp1.y)
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
        
        
    }
    
    
    
    
    var faceRadius: CGFloat {
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }
    
    
    
    override func drawRect(rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = 3
        color.set()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        
        let smiliness = dataSource?.similinessForFaceView(self) ?? 0.0
        let smilepath = bezierPathForSmile(smiliness)
        smilepath.stroke()
    }
    
}
