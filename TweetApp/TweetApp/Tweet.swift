//
//  Tweet.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/4/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favoriteCount: Int?
    var dictionary: NSDictionary
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        favoriteCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetswithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}