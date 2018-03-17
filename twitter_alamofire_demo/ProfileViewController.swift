//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mike Lin on 3/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var profileBackgroundImage: UIImageView!
    @IBOutlet weak var userAccountLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    
    
    
    
    let user = User.current!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureImage.af_setImage(withURL: user.profilePictureURL)
        userAccountLabel.text = user.name
        userHandleLabel.text = "@\(user.screenName)"
        
        tweetCountLabel.text = "\(user.tweetsCount)"
        followingCountLabel.text = "\(user.followingCount)"
        followerCountLabel.text = "\(user.followersCount)"
        
    }

}
