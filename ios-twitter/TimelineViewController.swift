//
//  TimelineViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/25/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl! = nil
    var contentOffset:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backItem?.title = "Logout"
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetCreated:" , name: "tweetCreated", object: nil)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, belowSubview: tableView)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "onContentSizeChange:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
        
        self.title = "Timeline"
        populate(refreshing: false)
        
    }

    func onContentSizeChange(notification: NSNotification) {
        
        //tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //tableView.contentOffset.y = self.contentOffset
        //super.viewDidAppear(animated)
        //tableView.reloadData()
    }
    
    func loadTimeline(tweets: [Tweet]) {
    
        self.tweets = tweets
        self.tableView.reloadData()
    }
    
    func refreshData(sender: AnyObject) {
    
        populate(refreshing: true)
    }
    
    func populate(refreshing: Bool = false) {
        
        ViewHelpers.showProgress(self.view, text: "Loading")
    
        User.currentUser?.getHomeTimeline(nil, completion: { (tweets, error) -> () in
            
            if (refreshing) {
                
                self.refreshControl.endRefreshing()
            }
            
            if (tweets != nil) {
                
                self.loadTimeline(tweets!)
                ViewHelpers.dismissProgress(self.view)
            }
            
            if (error != nil) {
                
                println(error)
                ViewHelpers.showErrorBar("Error Fetching Tweets", forDuration: 10)
                ViewHelpers.dismissProgress(self.view)
            }
        })
        
    }
    
    func tweetCreated(sender: AnyObject) {
    
        if let newTweet = sender.object as? Tweet {
        
            tweets.insert(newTweet, atIndex: 0)
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.contentOffset = tableView.contentOffset.y
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }*/

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        
        User.currentUser?.logout()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogout", object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "tweetViewSegue" {
        
            if let tweetCell = sender as? TimelineCell {
                
                let vc = segue.destinationViewController as TweetViewController
                vc.tweet = tweetCell.tweet
            }
        } else if segue.identifier == "tempSegue" {
        
            //let vc = segue.destinationViewController as NewHomeViewController
            let webViewNavigationController = segue.destinationViewController as UINavigationController
            let vc = webViewNavigationController.viewControllers[0] as NewHomeViewController
            vc.recentTweets = tweets

        } else if segue.identifier == "profileFromTimelineSegue" {
        
            let vc = segue.destinationViewController as ProfileController
            //println(sender)
            
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }

    @IBAction func cellTapped(sender: UITapGestureRecognizer) {
        
        /*
        println("Cell Tapped")
        println(sender)
        performSegueWithIdentifier("tweetViewSegue", sender: sender.view)
        */
    }
}
