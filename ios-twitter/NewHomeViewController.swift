//
//  NewHomeViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 10/4/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class NewHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tempNavBar: UINavigationBar!
    @IBOutlet weak var sidebar: UITableView!
    @IBOutlet weak var contentViewXConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    var navBar: UINavigationBar?
    var recentTweets: [Tweet] = []
    var viewControllers: [UIViewController] = []
    var cells: [SidebarCell] = []
    var sidebarTimelineCell: SidebarCell?
    var sidebarProfileCell: SidebarCell?
    
    var activeController: UIViewController? {
    
        didSet(oldViewControllerOrNil) {
        
            if let oldVC = oldViewControllerOrNil {
            
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            
            if let newVC = activeController {
                
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
                let navBar = newVC.navigationController?.navigationBar
            }            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sidebar.delegate = self
        sidebar.dataSource = self
        //sidebar.rowHeight = UITableViewAutomaticDimension
        contentViewXConstraint.constant = 0
        var newNavBarFrame = CGRectMake(tempNavBar.frame.minX
            , tempNavBar.frame.minY, tempNavBar.frame.width, tempNavBar.frame.height + 100)
        
        tempNavBar.frame = newNavBarFrame
        tempNavBar.tintColor = .whiteColor()
        tempNavBar.frame.size = CGSizeMake(tempNavBar.frame.width, 200)

        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timelineController = storyboard.instantiateViewControllerWithIdentifier("timelineNavigationController") as UINavigationController
        let profileController = storyboard.instantiateViewControllerWithIdentifier("TempViewController") as UIViewController
        
        let vc = timelineController.viewControllers[0] as TimelineViewController
        self.recentTweets = vc.tweets
        
        viewControllers.append(timelineController)
        viewControllers.append(profileController)
        sidebarTimelineCell = self.timelineCell()
        sidebarProfileCell = self.profileCell()
        cells.append(sidebarTimelineCell!)
        cells.append(sidebarProfileCell!)
        self.activeController = self.viewControllers.first
        
        
        navBar = UINavigationBar(frame: CGRectMake(0, 0, 250, 60))
        navBar!.backgroundColor = .blueColor()
        navBar!.hidden = true
        self.view.addSubview(navBar!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetsFetched:" , name: "tweetsFetched", object: nil)
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tweetsFetched(sender: AnyObject) {
    
        self.recentTweets = sender.object as [Tweet]
        sidebarTimelineCell = timelineCell()
        cells[0] = sidebarTimelineCell!
        sidebar.reloadData()
        self.view.layoutIfNeeded()
        //animate()
    }
    
    
    func animate() {
        
        /*
        var imgView = self.sidebarTimelineCell?.imageView
  
        UIView.transitionWithView(imgView!, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in
            
                self.sidebarTimelineCell?.backgroundColor = .greenColor()
                self.sidebarProfileCell?.imageView!.image = tempImg
                self.sidebarProfileCell?.textLabel?.text = "Hello"
                self.view.layoutIfNeeded()
            
            }) { (finished: Bool) -> Void in
        }*/
        
        
        /*
        let tempImg = UIImage(named: "bg.jpg")
        var imgView = self.sidebarTimelineCell?.imageView
        UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
            
            println("hello")
            self.sidebarTimelineCell?.backgroundColor = .greenColor()
            self.sidebarTimelineCell?.backgroundColor = .greenColor()
            self.sidebarProfileCell?.imageView!.image = tempImg
            self.sidebarProfileCell?.textLabel?.text = "Hello"
            self.view.layoutIfNeeded()

            }, completion: { (finished: Bool) -> Void in
        })*/
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    func timelineCell() -> SidebarCell {
    
        var cell = sidebar.dequeueReusableCellWithIdentifier("SidebarCell") as SidebarCell
        cell.headerTextLabel.text = "Timeline"
        cell.segue = "timelineSegue"
        if (recentTweets.count > 0) {
        
            //let tweet = recentTweets[0]
            let tweet = randomTweet()
            cell.cellText.text = tweet.text
            if let biggerProfileImage = tweet.user?.profileBigImageUrl {
                
                cell.cellImage.setImageWithURL(NSURL(string: biggerProfileImage))
            }
        }
        
        return cell
    }
    
    func profileCell() -> SidebarCell {

        var cell = sidebar.dequeueReusableCellWithIdentifier("SidebarCell") as SidebarCell
        cell.headerTextLabel.text = "Profile"
        if let biggerProfileImage = User.currentUser?.profileBigImageUrl {
        
            cell.cellImage.setImageWithURL(NSURL(string: biggerProfileImage))
        }
        cell.segue = "profileSegue"
        println(User.currentUser?.tagline)
        if let tagline = User.currentUser?.tagline {
        
            cell.cellText.text = "\(tagline)"
            if let name = User.currentUser?.name {
            
                cell.titleLabel.text = name
            }
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.activeController = self.viewControllers[indexPath.row]
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            
            self.contentViewXConstraint.constant = 0
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        
        
        if sender.state == .Ended {
        
            // get the width of current view
            let width = self.view.frame.width
            //contentViewXConstraint.constant = -(width - 32)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.contentViewXConstraint.constant = -(250)
                self.navBar?.hidden = true
                self.view.layoutIfNeeded()
                
                }, completion: { (finished: Bool) -> Void in
                    
                    self.animate()
                })
            
            
            /*
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                

                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                  
                    var tweet = self.randomTweet()
                    if let biggerProfileImage = tweet.user?.profileBigImageUrl {
                        
                        var imgView = self.sidebarTimelineCell?.imageView
                        imgView?.setImageWithURL(NSURL(string: biggerProfileImage))
                        //self.sidebar.reloadData()
                        self.view.layoutIfNeeded()

                    }
                })
                
            })*/
        }
    }
    
    @IBAction func didSwipeLeft(sender: UISwipeGestureRecognizer) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            
            self.contentViewXConstraint.constant = 0
            self.navBar?.hidden = true
            self.view.layoutIfNeeded()
        })
    }
    
    func randomTweet() -> Tweet {
    
        var randomNumber : Int = Int(rand()) % (recentTweets.count - 1)
        return recentTweets[randomNumber]
    }
    
    func onTimer() {
    
        var tweet = randomTweet()
        self.sidebarTimelineCell?.cellText.alpha = 0.2
        self.sidebarTimelineCell?.cellImage.alpha = 0.2
        
        UIView.animateWithDuration(
            1, delay: 0, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in

                if let url = tweet.user?.profileBigImageUrl {
                    
                    self.sidebarTimelineCell?.cellImage?.setImageWithURL(NSURL(string: url))
                }
                self.sidebarTimelineCell?.cellText.text = tweet.text
                self.sidebarTimelineCell?.cellText.alpha = 1
                self.sidebarTimelineCell?.cellImage.alpha = 1
                self.view.layoutIfNeeded()

            }) { (finished: Bool) -> Void in
        }
    }
}
