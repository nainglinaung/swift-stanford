//
//  ViewController.swift
//  Autolayout
//
//  Created by Naing Lin Aung on 3/9/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    var secure:Bool = false { didSet { updateUI() }}
    
    var image:UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            println("hi'")
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioContstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectedRatio,
                        constant: 0)
                } else {
                    aspectRatioContstraint = nil
                }
            }
        }
    }
    
    
    
    
    var aspectRatioContstraint:NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioContstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint  = aspectRatioContstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
    var loggedInUser:User? { didSet{
        println("didset")
        
        updateUI() }}
    
    
  
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func login() {
       
        loggedInUser = User.login(loginField.text ?? "",password: passwordField.text ?? "")
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text =  loggedInUser?.name
        companyLabel.text =  loggedInUser?.company
        image = loggedInUser?.image
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension User
{
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        } else {
            return UIImage(named: "unknown_user")
        }
    }
}



extension UIImage {
    var aspectedRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}


