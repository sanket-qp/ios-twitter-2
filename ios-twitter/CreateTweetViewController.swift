//
//  CreateTweetViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    var counterLabel: UILabel!
    var regularColor: UIColor!
    var replyTo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        counterLabel = UILabel(frame: CGRect(x: 270, y: 10, width: 20, height: 20))
        counterLabel.text = "140"
        self.navigationItem.titleView = counterLabel
        textView.delegate = self
        regularColor = counterLabel.backgroundColor
        textView.becomeFirstResponder()
        
        //let constraint = NSLayoutConstraint(item: counterLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.navigationItem.rightBarButtonItem, attribute: NSLayoutAttribute.LeftMargin, multiplier: 1.0, constant: 1)
        //self.view.addConstraint(constraint)
        //self.textView.text = ""
        populate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
     
        TwitterClient.sharedInstance.createTweet(User.currentUser!, text: textView.text, completion: { (tweet, error) -> () in
            
            if (tweet != nil) {
                
                NSNotificationCenter.defaultCenter().postNotificationName("tweetCreated", object: tweet)
                ViewHelpers.dismissProgress(self.view)
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else if (error != nil) {
                
                println("error creating tweet")
                ViewHelpers.dismissProgress(self.view)
                ViewHelpers.showErrorBar("Error Creating Tweet")
            }
        })
        
        ViewHelpers.showProgress(self.view, text: "Processing")
    }
    
    func populate() {
    
        screenNameLabel.text = User.currentUser!.screenName
        nameLabel.text = User.currentUser?.name
        if let profileImageURL = User.currentUser?.profileImageUrl {
        
            profileImage.setImageWithURL(NSURL(string: profileImageURL))
        }
        
        if (replyTo != nil) {
        
            textView.text = "\(replyTo!) "
        }
        
        counterLabel.textColor = UIColor.grayColor()
    }

    func characterCount() -> Int {
    
        let charsAllowed = 140
        let charsEntered = textView.text.utf16Count
        return (charsAllowed - charsEntered)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
    }
    
    func textViewDidChange(textView: UITextView) {
        
        if (characterCount() < 0) {
        
            notAllowed()
            
        } else {
        
            allowed()
            
        }
    }
    
    func allowed() {

        tweetButton.enabled = true
        counterLabel.text = "\(characterCount())"
        counterLabel.textColor = UIColor.grayColor()
    }
    
    func notAllowed() {
        
        tweetButton.enabled = false
        counterLabel.text = "\(characterCount())"
        counterLabel.textColor = .redColor()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onCancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)

    }
}
