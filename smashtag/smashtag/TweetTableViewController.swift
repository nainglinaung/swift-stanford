//
//  TweetTableViewController.swift
//  smashtag
//
//  Created by Naing Lin Aung on 3/11/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    var tweets = [[Tweet]]()
    
    var search: String?  = "#stanford" {
        didSet {
            lastSuccessfulRequest = nil
            searchText?.text = search
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        if search != nil {
            refresh()
        }
        
    }

    var lastSuccessfulRequest : TwitterRequest?
    
    var nextRequestToAttempt : TwitterRequest? {
        if lastSuccessfulRequest == nil {
            if searchText != nil {
                return TwitterRequest(search: search!, count: 100)
            } else {
                return nil
            }
        } else {
            return lastSuccessfulRequest?.requestForNewer
        }
    }
    
    
    
    @IBAction func refresh(sender: UIRefreshControl?) {
        
            if let request  = nextRequestToAttempt {
                request.fetchTweets { (newTweets) -> Void in
                    println(newTweets)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if newTweets.count > 0 {
                            self.tweets.insert(newTweets, atIndex: 0)
                            self.tableView.reloadData()
                            self.lastSuccessfulRequest = request
                        }
                        sender?.endRefreshing()
                    })
                }
            } else {
                sender?.endRefreshing()
            }
    }
    
    
    

    
    
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }
   
    
 
    
    @IBOutlet weak var searchText: UITextField! {
        didSet{
            searchText.delegate = self
            searchText.text = search
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchText {
            textField.resignFirstResponder()
            search = searchText.text
        }
        return true
    }
    
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITable view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tweets[section].count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as TweetTableViewCell

        cell.tweet = tweets[indexPath.section][indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
