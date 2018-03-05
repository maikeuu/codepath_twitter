//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool?
    
    var tweet: Tweet! {
        didSet {
            usernameLabel.text = tweet.user.name
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            tweetTextLabel.text = tweet.text
            favorited = tweet.favorited!
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
    }
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
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
                tweet.favoriteCount! -= 1
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
