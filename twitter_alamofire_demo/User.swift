//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    
    //User Properties
    var name: String
    var profilePictureString: String //String of the profile picture of the tweet
    var profilePictureURL: URL // URL conversion from string above of the profile picture of tweet
    var screenName: String //Handle of User
    
    //For user persistance
    var dictionary: [String: Any]?
    
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        profilePictureString = dictionary["profile_image_url"] as! String
        profilePictureURL = URL(string: profilePictureString)!
        screenName = dictionary["screen_name"] as! String
    }
}
