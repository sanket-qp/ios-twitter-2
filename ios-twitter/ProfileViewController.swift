//
//  ProfileViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 10/4/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

/*
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: User?
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var tableView: UITableView!
    var navBarOriginalFrame: CGRect?
    var originalNavBar: UINavigationBar?
    var backButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //panGestureRecognizer.delegate = self
        
        navBarOriginalFrame = navigationController?.navigationBar.frame
        user = User.currentUser
        originalNavBar = navigationController?.navigationBar
        // when view loads, hide the navbar and overlap it with header section of the table
    
        self.navigationController?.navigationBar.translucent = true
        }
    }
    
    func changeNavBar() {

        //self.navigationController?.navigationBar.hidden = true

    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
            return profileHeaderCell()
            
        } else {
        
        
            return timelineCell()
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
        
            return 0
        }
        
        return 1
    }
    
    func timelineCell() -> TimelineCell {
    

        
        
    }
    
    func profileHeaderCell() -> ProfileHeaderCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell") as ProfileHeaderCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {

            return 80
        }
        
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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

        let width = view.frame.width
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 80))
        //headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8 )
        var bannerImage = UIImageView(image: UIImage(named: "bg.jpg"))
        
        if let bannerImageUrl = User.currentUser?.bannerImageUrl {
        
            println(bannerImageUrl)
            bannerImage.setImageWithURL(NSURL(string: bannerImageUrl))
        }

        bannerImage.frame = CGRect(x: 0, y: 0, width: width, height: 80)
//      headerView.addSubview(UIImageView(image: tempImg))
        headerView.addSubview(bannerImage)
        return headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        println("beging dragging")
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {

        /*
        var originalFrame = navigationController?.navigationBar.frame
        
        if (sender.state == .Began) {
            
            // set the starting position and height
            let originalFrame = navigationController?.navigationBar.frame
            
        } else if (sender.state == .Changed) {
            
            // keep dragging
            println("here")
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                let location = sender.locationInView(self.view)
                let newRect = CGRect(x: 0, y: 20, width: 320, height: location.y)
                self.navigationController?.navigationBar.frame = newRect
            })

        } else if (sender.state == .Ended) {
            
            println("ended")
            // put back to original position and height
            UIView.animateWithDuration(0.3, animations: { () -> Void in
              
                println("hello")
                self.navigationController?.navigationBar.frame = self.navBarOriginalFrame!
                
            })
        }*/
    }
}*/
