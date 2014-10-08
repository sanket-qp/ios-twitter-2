//

//  TimelineCell.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell, UIGestureRecognizerDelegate {

    var tweet: Tweet! {
    
        willSet(tweet) {
        
            populate(tweet)
        }
    }
    
    
    @IBOutlet weak var profileImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetedImageTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var retweetedLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var durationLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var retweetedImage: UIImageView!
    @IBOutlet weak var retweetedByLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var numOfFavoritesLabel: UILabel!
    @IBOutlet weak var numOfRetweetsLabel: UILabel!
    var tapRecognizer: UITapGestureRecognizer?

    
    var isFavorite: Bool = false
    var isRetweeted: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetFavorited:" , name: "tweetFavorited", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetUnFavorited:" , name: "tweetUnFavorited", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetRetweeted:" , name: "tweetRetweeted", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetUnRetweeted:" , name: "tweetUnRetweeted", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetNotChanged:" , name: "tweetNotChanged", object: nil)
        
        self.userInteractionEnabled = true
        self.imageView?.userInteractionEnabled = true
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        tapRecognizer!.numberOfTouchesRequired = 1
        tapRecognizer!.delegate = self
        self.imageView!.addGestureRecognizer(tapRecognizer!)
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func tweetFavorited(sender: AnyObject) {
        
        if let modifiedTweet = sender.object as? Tweet {
        
            if modifiedTweet.id == tweet.id {
            
                println("favoriting timeline: \(tweet.text)")
                
                var cnt = tweet.favoriteCount!
                cnt += 1
                numOfFavoritesLabel.text = "\(cnt)"
                toggle(true, button: favoriteButton, named: "favorite_on")
            }
        }
    }
    
    
    func tweetUnFavorited(sender: AnyObject) {
        
        if let modifiedTweet = sender.object as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                println("un-favoriting timeline : \(tweet.text)")
                toggle(false, button: favoriteButton, named: "favorite_default")
                
                var cnt = tweet.favoriteCount!
                if (cnt > 0) {
                    
                    cnt -= 1
                }
                
                numOfFavoritesLabel.text = "\(cnt)"
            }
        }
    }
    
    
    func tweetRetweeted(sender: AnyObject) {
                
        if let modifiedTweet = sender.object as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                println("HERE HERE: timeline : \(modifiedTweet.id)")
                toggle(true, button: retweetButton, named: "retweet_on")
                retweetButton.enabled = false
                var cnt = tweet.retweetCount!
                cnt += 1
                numOfRetweetsLabel.text = "\(cnt)"
            }
        }
        
    }
    
    
    func tweetUnRetweeted(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                toggle(false, button: favoriteButton, named: "retweet_default")
                
                var cnt = tweet.retweetCount!
                if (cnt > 0) {
                    
                    cnt -= 1
                }
                
                numOfRetweetsLabel.text = "\(cnt)"
            }
        }
    }
    
    func tweetNotChanged(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                populate(tweet)
            }
        }
    }
    
    func populate(tweet: Tweet) {
    
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenName
        tweetTextLabel.text = tweet.text
        numOfFavoritesLabel.text = "\(tweet.favoriteCount!)"
        numOfRetweetsLabel.text = "\(tweet.retweetCount!)"

        isFavorite = tweet.favorited ?? false
        let favoriteImage = isFavorite ? "favorite_on" : "favorite_default"
        toggle(isFavorite, button: favoriteButton, named: favoriteImage)
        
        isRetweeted = tweet.reTweeted ?? false
        let retweetImage = isRetweeted ? "retweet_on" : "retweet_default"
        toggle(isRetweeted, button: retweetButton, named: retweetImage)
        if isRetweeted {
        
            retweetButton.enabled = false
        }
        
        let imageUrl = isRetweeted ? tweet.originalUser?.profileImageUrl : tweet.user?.profileImageUrl
        
        if (imageUrl != nil) {
        
            profileImage.setImageWithURL(NSURL(string: imageUrl!))
        }
    
        if (isRetweeted) {
        
            if let retweetedBy = tweet.user?.name {
                
                retweetedByLabel.text = "\(retweetedBy) retweeted"
            }
            
        } else {
        
            
            retweetedImage.hidden = true
            retweetedByLabel.hidden = true
            let temp1 = retweetedLabelTopConstraint.constant
            let temp2 = retweetedImageTopConstraint.constant
            
            retweetedLabelTopConstraint.constant = 0
            retweetedImageTopConstraint.constant = 0
            /*
            profileImageTopConstraint.constant = temp2
            nameLabelTopConstraint.constant = temp1*/
        }
        
        /*
        let replyY = replyButton.frame.maxY
        let reTweetFrame = retweetButton.frame
        let newFrame = CGRect(x: reTweetFrame.minX, y: replyY, width: reTweetFrame.width, height: reTweetFrame.height)
        retweetButton.frame = newFrame*/
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        isFavorite = !isFavorite
        var image: UIImage!
        //isFavorite ? toggle(true, button: favoriteButton, named: "favorite_on") : toggle(false, button: favoriteButton, named: "favorite_default")
        
        tweet.favorite { (tweet, error) -> () in
            
            if (tweet != nil) {
                
                self.isFavorite = tweet!.favorited!
                //self.tweet = tweet
            
            } else if (error != nil) {
            
                // restore the button state
                self.isFavorite = !self.isFavorite
                self.isFavorite ? self.toggle(true, button: self.favoriteButton, named: "favorite_on") : self.toggle(false, button: self.favoriteButton, named: "favorite_default")
                ViewHelpers.showErrorBar("Error, please try again", forDuration: 10)
            }
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        isRetweeted = !isRetweeted
        isRetweeted ? toggle(true, button: retweetButton, named: "retweet_on") : toggle(false, button: retweetButton, named: "retweet_default")
        
        tweet.reTweet { (tweet, error) -> () in
            
            if (tweet != nil) {
            
                println("retweeted")
                self.tweet = tweet
                
            } else if (error != nil) {
            
                println(error)

            }
        }
    }
    
    func toggle(on: Bool, button: UIButton, named: String) {
    
        let image = UIImage(named: named)
        button.setImage(image, forState: UIControlState.Normal)
    }
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer.view == self.imageView) {
        
        
            println("image view tapped")
            return true
            
        } else {
        
            println("cell tapped")
            return false
        }
        
    }
    
    func handleTap(sender: AnyObject) {
    
    
        println("handle tap")
        
    }
    
    func didTap(sender: AnyObject) {
    
        println("did tap")
    }
}
