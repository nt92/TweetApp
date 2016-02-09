//
//  TweetsViewController.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/4/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?
    var refresh: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.tweets != nil {
            return (self.tweets?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as? TweetCell
        
        cell?.tweet = tweets![indexPath.row]
        
        return cell!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refresh, atIndex: 0)
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(
            nil, completion: { (tweets, error) -> () in
                if(error == nil) {
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
        })
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance.homeTimelineWithCompletion(
            nil, completion: { (tweets, error) -> () in
                if(error == nil) {
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
        })
        
        delay(2, closure: {
            self.refresh.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailedTweetsViewController
        detailViewController.tweet = tweet
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    

}
