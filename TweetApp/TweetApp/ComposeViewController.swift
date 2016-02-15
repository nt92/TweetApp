//
//  ComposeViewController.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/14/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var userText: UITextField!
    
    @IBAction func onChangeText(sender: AnyObject) {
        let temp = userText.text
        let numTemp = temp?.characters.count
        charCount.text = "\(140 - numTemp!)"
        if (Int(charCount.text!)! <= 0) {
            userText.text = String(userText.text!.characters.dropLast())
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPost(sender: AnyObject) {
        if (userText.text != nil) {
            let messageToSend = userText.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            TwitterClient.sharedInstance.postTweet(messageToSend)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
