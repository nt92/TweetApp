//
//  TweetsViewController.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/4/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    

}
