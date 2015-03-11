//
//  TweetTableViewCell.swift
//  smashtag
//
//  Created by Naing Lin Aung on 3/11/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
  
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        // tweetCreatedLabel?.text = nil
        
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
            }
        }
            
        tweetScreenNameLabel?.text = "\(tweet.user)"
        
        if let profileImageURL = tweet.user.profileImageURL {
            if let imageData = NSData(contentsOfURL: profileImageURL) {
                tweetProfileImageView?.image = UIImage(data: imageData)
            }
        
        }
        
            // user description 
            
//            let formatter = NSDateFormatter()
//            if let profileImageURL = tweet.user.profileImageURL {
//                if NSDate().timeIntervalSinceNow(tweet.created) > 24*60*60 {
//                    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
//                } else {
//                    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//                }
//            }
            
        }
    }
    
    
    
}
