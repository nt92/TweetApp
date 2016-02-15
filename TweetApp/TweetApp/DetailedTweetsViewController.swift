//
//  DetailedTweetsViewController.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/8/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class DetailedTweetsViewController: UIViewController {

    var tweet: Tweet!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setImageWithURL(NSURL(string: (tweet!.user?.profileImageURL)!)!)
        userName.text = tweet!.user?.name
        let handle = tweet!.user?.name as String!
        userHandle.text = "@\(handle)"
        userTweet.text = tweet!.text
        dateTime.text = tweet!.createdAtString
        favLabel.text = String(tweet!.favoriteCount!)
        rtLabel.text = String(tweet!.retweetCount!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweetClick(sender: AnyObject) {
        if (!tweet.isRetweeted!) {
            rtButton.setImage(UIImage(named: "retweet-action-on.png"), forState: UIControlState.Normal)
            
            self.tweet.retweetCount!--
            rtLabel.text = String(tweet.retweetCount!)
            TwitterClient.sharedInstance.retweetMe(tweet.id!)
        }
        else {
            rtButton.setImage(UIImage(named: "retweet-action.png"), forState: UIControlState.Normal)
            
            self.tweet.retweetCount!++
            rtLabel.text = String(tweet.retweetCount!)
            TwitterClient.sharedInstance.unRetweetMe(tweet.id!)
        }
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        if (!tweet.isFavorited!) {
            favButton.setImage(UIImage(named: "like-action-on.png"), forState: UIControlState.Normal)
            
            TwitterClient.sharedInstance.favoriteMe(tweet.id!)
        }
        else {
            favButton.setImage(UIImage(named: "like-action.png"), forState: UIControlState.Normal)
            
            TwitterClient.sharedInstance.unFavoriteMe(tweet.id!)
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
