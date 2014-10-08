//
//  TweetDetailCell.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {

    
    var tweet: Tweet! {
    
        willSet(tweet) {
        
            populate(tweet)
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    
    func populate(tweet: Tweet) {
    
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenName
        tweetTextLabel.text = tweet.text
        createdAtLabel.text = tweet.createdAtString
        let isRetweeted = tweet.reTweeted ?? false
        let imageUrl = isRetweeted ? tweet.originalUser?.profileImageUrl : tweet.user?.profileImageUrl
        
        if (imageUrl != nil) {
            
            profileImage.setImageWithURL(NSURL(string: imageUrl!))
        }

        /*
        if let profileImageUrl = tweet.user?.profileImageUrl {
            println(User.currentUser?.profileImageUrl)
            profileImage.setImageWithURL(NSURL(string: profileImageUrl))
            
        }*/
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
