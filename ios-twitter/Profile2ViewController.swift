//
//  Profile2ViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 10/5/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class Profile2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var originalNavBar: UINavigationBar?
    var user: User?
    var bannerImage: UIImageView?
    @IBOutlet weak var tableView: UITableView!
    var fixedHeaderView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalNavBar = self.navigationController?.navigationBar
        user = User.currentUser
        tableView.delegate = self
        tableView.dataSource = self
        addBanner()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let intrinsicSize = self.fixedHeaderView?.intrinsicContentSize()
        let height = intrinsicSize?.height > 0 ? intrinsicSize?.height : 200
        let width = CGRectGetWidth(self.view.bounds)
        let frame = CGRectMake(0, 0, width, height!)
        
        self.fixedHeaderView?.frame = frame
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(height!, 0, 0, 0)
        
        let wrapperView = self.tableView.subviews[0] as UIView
        self.tableView.insertSubview(self.fixedHeaderView!, aboveSubview: wrapperView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var headerFrame = self.fixedHeaderView?.frame
        let yOffset = scrollView.contentOffset.y
        headerFrame?.origin.y = max(0, yOffset)
        self.fixedHeaderView?.frame = headerFrame!
        
        let height = CGRectGetHeight(headerFrame!)
        
        if yOffset < 0 {
        
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(abs(yOffset) + height, 0, 0, 0)
        
        }
        
    }

    func addBanner() {
        
        var rect = self.navigationController?.navigationBar.frame
        rect = self.tableView.frame
        var newHeight = rect!.height + 80
        var newRect = CGRect(x: rect!.minX, y: rect!.minY, width: rect!.width, height: 200)
        bannerImage = UIImageView(frame: newRect)
        bannerImage!.userInteractionEnabled = true
        
        if let bannerImageUrl = User.currentUser?.bannerImageUrl {
            
            println(bannerImageUrl)
            bannerImage!.setImageWithURL(NSURL(string: bannerImageUrl))
        }
        
        
        let bannerView = UIView(frame: newRect)
        bannerView.addSubview(bannerImage!)
        tableView.tableHeaderView = bannerView
        fixedHeaderView = bannerView
    }
    
    func changeNavBar() {
    
        // first change the height
        var rect = self.navigationController?.navigationBar.frame
        var newHeight = rect!.height + 50
        var newRect = CGRect(x: rect!.minX, y: rect!.minY, width: rect!.width, height: newHeight)
        self.navigationController?.navigationBar.frame = newRect
        
        // now set the image
        let bannerImageUrl = user?.bannerImageUrl
        var tempImage = UIImage(named: "bg.jpg")
        var tempImageView = UIImageView(image: tempImage)
        let url = NSURL(string: bannerImageUrl!)
        /* tempImageView.setImageWithURLRequest(urlRequest: NSURLRequest(URL: url), placeholderImage: tempImage , success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
            
            println("Success")
            
            }) { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            
            println(error)
        }
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg.jpg"), forBarMetrics: UIBarMetrics.Default)
        */
    }
    
    func restoreNavBar() {
    
        var rect = self.navigationController?.navigationBar.frame
        var newHeight = rect!.height - 50
        var newRect = CGRect(x: rect!.minX, y: rect!.minY, width: rect!.width, height: newHeight)
        self.navigationController?.navigationBar.frame = newRect
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        //self.restoreNavBar()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
        
            return 1
        }
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        if (section == 0) {
        
            return userStatsCell(indexPath)
        }
        
        return timelineCell(indexPath)
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let width = view.frame.width
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8 )
        var headerLabel = UILabel(frame: CGRect(x:10, y:0, width: 320, height: 50))
        headerLabel.text = "Section : \(section)"
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    
    func userStatsCell(indexPath: NSIndexPath) -> UserStatsCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("UserStatsCell") as UserStatsCell
        cell.numOfFollowersLabel.text = "\(user?.numOfFollowers)"
        cell.numOfFollowingLabel.text = "\(user?.numOfFollowings)"
        cell.numOfTweetsLabel.text = "\(user?.numOfTweets)"
        return cell
    }
    
    
    func timelineCell(indexPath: NSIndexPath) -> TimelineCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
