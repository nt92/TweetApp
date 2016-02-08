//
//  TwitterClient.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/1/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

let twitterConsumerKey = "ntdNd4YkebCg7VkrC31yBRtj9"
let twitterConsumerSecret = "8sdEDRs0GvLhr2RlpaeGycFYzxPwS6T3cV4eSZ11MzC0K3hUeB"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    var tweetsCompletion: ((tweets: [Tweet]?, error:NSError?) -> ())?

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error:NSError?) -> ()) {
        
        tweetsCompletion = completion
        
        //GET request to get home timeline tweets
        GET("1.1/statuses/home_timeline.json", parameters: params,
            success: { (operation:NSURLSessionDataTask, response:AnyObject?) -> Void in
                
                print(response)
                let tweets = Tweet.tweetswithArray(response as! [NSDictionary])
                //send data thru completion block
                self.tweetsCompletion!(tweets:tweets, error:nil)
            }, failure: { (operation:NSURLSessionDataTask?, error:NSError) -> Void in
                print("Couldn't get tweets")
                completion(tweets: nil, error: error)
                
        })
    }

    
    //GET request to do OAuth login
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    //POST request to get access token
    func openURL(url:NSURL){
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //GET request for user information
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("It worked!!!")
                //testing serialization
                let my_user = User(dictionary: response as! NSDictionary)
                //setCurrentUser globally
                User.currentUser = my_user
                self.loginCompletion?(user: my_user, error:nil)
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("Could not get User")
                    self.loginCompletion?(user:nil, error:error)
            })
            
            //Access error
            }) { (error: NSError!) -> Void in
                print("Failed to Recieve Access Token")
                self.loginCompletion?(user:nil, error:error)
        }
    }
    
}
