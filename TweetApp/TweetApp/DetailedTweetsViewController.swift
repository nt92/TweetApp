//
//  DetailedTweetsViewController.swift
//  TweetApp
//
//  Created by Nikhil Thota on 2/8/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class DetailedTweetsViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userName.text = tweet!.user?.name
        
        // Do any additional setup after loading the view.
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
