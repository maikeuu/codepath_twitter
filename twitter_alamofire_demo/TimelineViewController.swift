//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    var tweets: [Tweet] = []
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 150
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRefreshControl()
    }
    
    func getTimeLine() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        tableView.reloadData()
    }
    
    func refreshTweets(_ refreshControl: UIRefreshControl) {
        getTimeLine()
        refreshControl.endRefreshing()
    }
    
    func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTweets(_:)), for: UIControlEvents.valueChanged)
        refreshTweets(refreshControl)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                let vc = segue.destination as! TweetDetailViewController
                vc.tweet = tweet
            }
        }
        else if segue.identifier == "ComposeTweetSegue" {
            let vc = segue.destination as! ComposeTweetViewController
            vc.delegate = self
        }
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
        User.current = nil
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func didTapCompose(_ sender: Any) {
        performSegue(withIdentifier: "ComposeTweetSegue", sender: sender)
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TimelineViewController: ComposeTweetViewControllerDelegate {
    func did(post: Tweet) {
        self.getTimeLine()
    }
    
    
}


