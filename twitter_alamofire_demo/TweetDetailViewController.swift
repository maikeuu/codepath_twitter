//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mike Lin on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var timeCreatedLabel: UILabel!
    
    
    var tweet: Tweet?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
            usernameLabel.text = tweet.user.name
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            userProfilePicture.af_setImage(withURL: tweet.user.profilePictureURL)
            userHandleLabel.text = "@\(tweet.user.screenName)"
            userHandleLabel.textColor = .gray
            tweetTextLabel.text = tweet.text
            timeCreatedLabel.text = tweet.createdAtString
            timeCreatedLabel.textColor = .gray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
