//
//  TempViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 10/5/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit


class TempViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numOfTweetsLabel: UILabel!
    @IBOutlet weak var numOfFollowing: UILabel!
    @IBOutlet weak var numOfFollowersLabel: UILabel!
    var refreshControl: UIRefreshControl! = nil
    var pageControl: UIPageControl?
    var user: User?
    var bannerImage: UIImageView?
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        scrollView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        user = User.currentUser
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
        addBanner()
        populate(refreshing: false)
        self.title = "Profile"
        
        
        pageControl = UIPageControl(frame: CGRectMake(135, 180, 50, 10))
        //pageControl?.backgroundColor = .redColor()
        pageControl?.numberOfPages = 3
        pageControl?.pageIndicatorTintColor = .grayColor()
        pageControl?.currentPageIndicatorTintColor = .redColor()
        self.view.addSubview(pageControl!)

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        

        let page = floor((scrollView.contentOffset.x - self.view.frame.width / 2) / self.view.frame.width) + 1;
        pageControl!.currentPage = Int(page)
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBanner() {
        
        
        let height = CGFloat(250)
        scrollView.pagingEnabled = true
        scrollView.frame = CGRectMake(0, 0, 640, height)
        bannerImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, height))
        //bannerImage?.alpha = 0.8
        bannerImage!.userInteractionEnabled = true
        bannerImage!.contentMode = UIViewContentMode.ScaleToFill
        if let bannerImageUrl = User.currentUser?.bannerImageUrl {
            
            bannerImage!.setImageWithURL(NSURL(string: bannerImageUrl))
        }

        
        let logoX = (self.view.frame.width)/2
        let logoY = (height)/2
        // custom view for logo and screen name
        var logoView = UIView(frame: CGRectMake(0, 0, 100, 100))
        //logoView.backgroundColor = .redColor()
        //logoView.center = bannerImage!.center
        logoView.center = CGPoint(x: self.view.frame.width/2, y: height/2)
        
        let name = user!.name!
        let nameLabel = UILabel()
        nameLabel.text = "\(name)"
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        nameLabel.tintColor = .yellowColor()
        nameLabel.sizeToFit()
        
        let screenName = user!.screenName!
        let screenNameLabel = UILabel()
        screenNameLabel.text = "\(screenName)"
        screenNameLabel.sizeToFit()
        logoView.addSubview(nameLabel)
        
        let logoImage = UIImageView(frame: CGRectMake(0, 10, 73, 73))
        //logoImage.center = bannerImage!.center
        logoImage.center = logoView.center
        logoImage.alpha = 0.5
        if let logoUrl = user?.profileBigImageUrl {
            
            logoImage.setImageWithURL(NSURL(string: logoUrl))
        }
        
        bannerImage?.addSubview(logoView)
        bannerImage?.addSubview(logoImage)
        
        var tempImageView = UIImageView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.width, height))
        tempImageView.image = UIImage(named: "bg.jpg")
        tempImageView.contentMode = UIViewContentMode.ScaleToFill
        
        scrollView.addSubview(bannerImage!)
        scrollView.addSubview(profileInfoView())
        scrollView.contentSize = CGSizeMake(self.view.frame.width*2, 140)
        
        logoImage.alpha = 0.2
        bannerImage?.alpha = 0.8
        nameLabel.alpha = 0.2
        logoImage.transform = CGAffineTransformMakeScale(0.2, 0.2)
        
        let tempImage = UIImage(named: "bg.jpg")
        
        /*
        UIView.animateWithDuration(
            0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                logoImage.alpha = 1
                logoImage.transform = CGAffineTransformMakeScale(1, 1)
                
        }, completion: nil)*/
        
        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            
            //self.bannerImage?.alpha = 0.4
            logoImage.alpha = 1
            logoImage.transform = CGAffineTransformMakeScale(0.8, 0.8)
            nameLabel.alpha = 1
            
        })
    }
    
    func profileInfoView() -> UIView {

        let height = CGFloat(250)
        let wrapper = UIView(frame: CGRectMake(self.view.frame.width, 0, self.view.frame.width, height))
        //wrapper.backgroundColor = UIColor(white: 0.8, alpha: 0.2)

        
        let logoImage = UIImageView(frame: CGRectMake(125, 100, 73, 73))
        logoImage.alpha = 0.5
        if let logoUrl = user?.profileBigImageUrl {
            
            logoImage.setImageWithURL(NSURL(string: logoUrl))
        }
        logoImage.contentMode = UIViewContentMode.ScaleToFill

        
        //wrapper.backgroundColor = .lightGrayColor()
        println(wrapper.frame)
        println(wrapper.center)
        
        wrapper.addSubview(logoImage)
        
        //let nameLabel = UILabel(frame: CGRectMake(self.view.frame.width, 100, 100, 10))
        let nameLabel = UILabel(frame: CGRectMake(110, 40, 100, 10))
        let name = user!.name!
        nameLabel.text = "\(name)"
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        nameLabel.tintColor = .yellowColor()
        //nameLabel.center = wrapper.center
        nameLabel.sizeToFit()
        
        
        let taglineLabel = UILabel(frame: CGRectMake(40, 60, self.view.frame.width, 10))
        let tagline = user!.tagline!
        taglineLabel.numberOfLines = 0
        taglineLabel.text = "\(tagline)"
        taglineLabel.sizeToFit()
        
        wrapper.addSubview(nameLabel)
        wrapper.addSubview(taglineLabel)
        
        
        logoImage.transform = CGAffineTransformMakeScale(0.2, 0.2)
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            
            //self.bannerImage?.alpha = 0.4
            logoImage.alpha = 1
            logoImage.transform = CGAffineTransformMakeScale(0.8, 0.8)
            
        })
        
        return wrapper
        
        /*
        var wrapperView = UIView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.width, height))
        wrapperView.backgroundColor = .greenColor()
        
        let tempView = UIView(frame: CGRectMake(10, 10, 100, 100))
        tempView.backgroundColor = .redColor()
        
        let tempTempView = UIView(frame: CGRectMake(10, 10, 50, 50))
        tempTempView.backgroundColor = .blueColor()
        tempView.addSubview(tempTempView)
        
        
        wrapperView.addSubview(tempView)*/
        
        
        /*
        var imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        if let normalUrl = user?.profileNormalImageUrl {
            
            imageView.setImageWithURL(NSURL(string: normalUrl))
        }
        
        wrapperView.addSubview(imageView)*/
        //return wrapperView
    }
    
    func loadTimeline(tweets: [Tweet]) {
        
        println("tweets : \(tweets.count)")
        self.tweets = tweets
        self.tableView.reloadData()
    }
    
    func refreshData(sender: AnyObject) {
        
        populate(refreshing: true)
    }
    
    func populate(refreshing: Bool = false) {
        
        if let numOfFollowers = user?.numOfFollowers {
            
            numOfFollowersLabel.text = "\(numOfFollowers)"
        }
        
        if let numOfTweets = user?.numOfTweets {
        
            numOfTweetsLabel.text = "\(numOfTweets)"
        }
        
        if let nOfFollowing = user?.numOfFollowings {
            
            numOfFollowing.text = "\(nOfFollowing)"
        }
        
        ViewHelpers.showProgress(self.view, text: "Loading")
        
        user?.getMentionsTimeline(nil, completion: { (tweets, error) -> () in
            
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "tweetViewFromProfileSegue" {
            
            if let tweetCell = sender as? TimelineCell {
                
                let vc = segue.destinationViewController as TweetViewController
                vc.tweet = tweetCell.tweet
            }
        } else if segue.identifier == "tempSegue" {
            
            let vc = segue.destinationViewController as NewHomeViewController
            vc.recentTweets = tweets
            
        } else if segue.identifier == "profileFromTimelineSegue" {
            
            let vc = segue.destinationViewController as ProfileController
            
        }
    }
}
