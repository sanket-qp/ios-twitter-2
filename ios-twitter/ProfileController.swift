//
//  ProfileController.swift
//  ios-twitter
//
//  Created by sanket patel on 10/5/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var user: User?
    var backButton: UIButton?
    var bannerImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.currentUser
        //backButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack:")
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height:20))
        backButton = UIButton()
        backButton?.backgroundColor = .whiteColor()
        backButton?.tintColor = .redColor()
        //backButton?.targetForAction("goBack:", withSender: self)
        backButton?.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton?.setTitle("Back", forState: nil)
        backButton?.setImage(UIImage(named: "arrow-left.png"), forState: UIControlState.Normal)
        bannerImage = UIImageView(image: UIImage(named: "bg.jpg"))
        bannerImage!.userInteractionEnabled = true
        
        if let bannerImageUrl = User.currentUser?.bannerImageUrl {
            
            println(bannerImageUrl)
            bannerImage!.setImageWithURL(NSURL(string: bannerImageUrl))
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // hide the navigation bar
        self.navigationController?.navigationBar.hidden = true
        
        /*
        let width = view.frame.width
        var tempView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        tempView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        tempView.addSubview(bannerImage!)
        tableView.tableHeaderView = tempView */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack(sender: AnyObject) {
    
        println("button clicked")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        

    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.hidden = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell.textLabel?.text = "Hello : \(indexPath.row)"
        return cell
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }
        
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        println("HERE : \(section)")

        
        if section == 0 {
            
            return bannerImageSection()
        }
        
        let width = view.frame.width
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8 )
        var headerLabel = UILabel(frame: CGRect(x:10, y:0, width: 320, height: 50))
        headerLabel.text = "Section : \(section)"
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func bannerImageSection() -> UIView? {
        
        println("HERE")
        let width = view.frame.width
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        bannerImage!.frame = CGRect(x: 0, y: 0, width: width, height: 100)
        headerView.addSubview(bannerImage!)
        headerView.addSubview(backButton!)
        return headerView
    }
    
    func timelineCell() -> TimelineCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
        return cell
    }
    
    
    func profileHeaderCell() -> ProfileHeaderCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell") as ProfileHeaderCell
        
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
