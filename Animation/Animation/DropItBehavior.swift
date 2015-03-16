//
//  DropItBehavior.swift
//  Animation
//
//  Created by Naing Lin Aung on 3/16/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class DropItBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()
    
    lazy var collider:UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
    }
   
    func addDrop(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
    }
    
    func removeDrop(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        drop.removeFromSuperview()
    }
    
}
