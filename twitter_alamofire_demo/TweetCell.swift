//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    //Header outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var timeCreatedLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var favorited: Bool?
    var retweeted: Bool?
    
    var tweet: Tweet! {
        didSet {
            //User object dependent views
            usernameLabel.text = tweet.user.name
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            userProfilePicture.af_setImage(withURL: tweet.user.profilePictureURL)
            userHandleLabel.text = "@\(tweet.user.screenName)"
            userHandleLabel.textColor = .gray
            
            //Tweet object dependent views
            tweetTextLabel.text = tweet.text
            favorited = tweet.favorited!
            retweeted = tweet.retweeted
            timeCreatedLabel.text = "•" + tweet.timeAgoSinceNow
            timeCreatedLabel.textColor = .gray
            updateUI()
        }
    }
    
    @IBAction func didTapFavorite(_ sender: UIButton) {
        if tweet.favorited == false {
            tweet.favorited = true
            favoriteTweet()
        } else {
            tweet.favorited = false
            unfavoriteTweet()
        }
        updateUI()
    }
    
    @IBAction func didTapRetweet(_ sender: UIButton) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            retweetTweet()
        }
    }
    
    func updateUI() {
        //Tweets Favorited case
        if tweet.favorited == true {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        //Tweets Retweeted case
        if tweet.retweeted == true {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        if tweet.retweetCount > 0 {
            retweetCountLabel.text = "\(tweet.retweetCount)"
        } else {
            retweetCountLabel.text = ""
        }
        if tweet.favoriteCount! > 0 {
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
        } else {
            favoriteCountLabel.text = ""
        }
    }
    
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.favoriteCountLabel.text = "\(tweet.favoriteCount! + 1)"
                self.updateUI()
            }
        }
    }
    
    func unfavoriteTweet() {
        APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                tweet.favorited = false
                self.favoriteCountLabel.text = "\(tweet.favoriteCount! - 1)"
                self.updateUI()
            }
        }
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.updateUI()
            }
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
