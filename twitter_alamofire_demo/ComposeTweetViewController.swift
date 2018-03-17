//
//  ComposeTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mike Lin on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView! {
        didSet {
            tweetTextView.becomeFirstResponder()
            tweetTextView.delegate = self
        }
    }
    
    var delegate: ComposeTweetViewControllerDelegate?
    
    let maxCharCount = 140

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterCountLabel.text = "\(maxCharCount - tweetTextView.text.count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        return newText.count <= maxCharCount
    }

    @IBAction func didPressPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


protocol ComposeTweetViewControllerDelegate {
    func did(post: Tweet)
}
