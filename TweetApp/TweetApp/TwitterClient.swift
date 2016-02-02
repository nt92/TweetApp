//
//  TwitterClient.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/1/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

let twitterConsumerKey = "LCdI2yDDrSc4SnjigG4RaspU2"
let twitterConsumerSecret = "EKZ9RFAtvM2k1ZVHsaOznRm4ANPAu450OCWAb46XYA9tirYbc8"
let twitterBaseURL = NSURL(string: "http://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
}
