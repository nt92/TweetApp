//
//  ProfileViewController.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/14/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var tweets: [Tweet]?
    var user: User?
    var tweet: Tweet!
    
    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profImage.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
        self.profImage.layer.cornerRadius = 20;
        self.profImage.clipsToBounds = true
        self.userName.text = "\(tweet.user!.name!)"
        self.bioLabel.text = "\(tweet.user!.tagLine!)"
        self.userHandle.text = "\(tweet.user!.handle!)"
        self.numTweets.text = "\(tweet.user!.tweetCount!)"
        self.numFollowers.text = "\(tweet.user!.followersCount!)"
        self.numFollowing.text = "\(tweet.user!.followingCount!)"
        self.locationLabel.text = "\(tweet.user!.location!)"
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
