//
//  TweetCell.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/7/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profPicture: UIImageView!
    @IBOutlet weak var twitterName: UILabel!
    @IBOutlet weak var twitterHandle: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var tweetDate: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    
    var isFavorite: Bool?
    var isRetweet: Bool?
    
    var tweet: Tweet! {
        didSet{
            profPicture.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
            twitterName.text = tweet.user?.name
            let handle = tweet.user?.name as String!
            twitterHandle.text = "@\(handle)"
            userTweet.text = tweet.text
            tweetDate.text = tweet.createdAtString
            favLabel.text = String(tweet.favoriteCount!)
            rtLabel.text = String(tweet.retweetCount!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        isFavorite = false
        isRetweet = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweer(sender: AnyObject) {
        if isRetweet == true {
            isRetweet = false
            self.tweet.retweetCount!--
            rtLabel.text = String(tweet.retweetCount!)
            
        } else {
            isRetweet = true
            self.tweet.retweetCount!++
            rtLabel.text = String(tweet.retweetCount!)
        }
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        
        if isFavorite == true {
            isFavorite = false
            self.tweet.favoriteCount!--
            favLabel.text = String(tweet.favoriteCount!)
            
        } else {
            isFavorite = true
            self.tweet.favoriteCount!++
            favLabel.text = String(tweet.favoriteCount!)
        }
    }
    

}
