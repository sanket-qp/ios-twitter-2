//
//  Tweet.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
class Tweet : NSObject {

    var id: String!
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int!
    var favoriteCount: Int!
    var reTweeted: Bool?
    var favorited: Bool?
    var originalUser: User?
    
    init(dict: NSDictionary) {
        
        super.init()
        
        if let id: AnyObject = dict["id_str"] {
            
            self.id = id as? String
        }
        
        user = User(dict: dict["user"] as NSDictionary)
        text = dict["text"] as? String
        createdAtString = dict["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        retweetCount = dict["retweet_count"] as? Int ?? 0
        favoriteCount = dict["favorite_count"] as? Int ?? 0
        reTweeted = dict["retweeted"] as? Bool
        favorited = dict["favorited"] as? Bool
   
        let retweetedStatus = dict["retweeted_status"] as? NSDictionary
        if (retweetedStatus != nil) {
        
            reTweeted = true
            originalUser = User(dict: retweetedStatus!["user"] as NSDictionary)
        }

        //println(dict)
        //println(text)
        //println(dict["favorite_count"])
        //println(retweetedStatus)
        //println("-------------------------------------")
        //println(self.user?.screenName)
        //println(self.reTweeted)
        //println(self.originalUser?.profileImageUrl)
        //println("================")
   
    }
    
    class func createTweetArray(dicts: [NSDictionary]) -> [Tweet] {
    
        return dicts.map({(tweet: NSDictionary) -> Tweet in
            
            Tweet(dict: tweet)
        
        })
    }
    
    class func createTweet() {
    
        
    }
    
    
    func favorite(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        let isFavorite = self.favorited!

        // if it's already favorite then we'll have to unfavorite it
        let notificationMsg = (isFavorite) ? "tweetUnFavorited" : "tweetFavorited"
        println(notificationMsg)
        NSNotificationCenter.defaultCenter().postNotificationName(notificationMsg, object: self)
        //TwitterClient.sharedInstance.favoriteActions(!isFavorite, tweet: self, completion: completion)
        TwitterClient.sharedInstance.favoriteActions(!isFavorite, tweet: self) { (tweet, error) -> () in
            
            if (tweet != nil) {
                
                self.id = tweet?.id
                self.favoriteCount = tweet?.favoriteCount
                self.favorited = tweet?.favorited
                completion(tweet: self, error: nil)
                
            } else if (error != nil) {
            
                NSNotificationCenter.defaultCenter().postNotificationName("tweetNotChanged", object: self)
                completion(tweet: nil, error: error)
            }
        }
        
    }
    func reTweet(completion: (tweet: Tweet?, error: NSError?) -> ()) {
    
        TwitterClient.sharedInstance.reTweet(self, completion: { (tweet, error) -> () in
            
            if (tweet != nil) {
            
                //NSNotificationCenter.defaultCenter().postNotificationName("tweetCreated", object: tweet)
                NSNotificationCenter.defaultCenter().postNotificationName("tweetRetweeted", object: self)
                completion(tweet: tweet, error: nil)
            
            } else if (error != nil) {
                
                NSNotificationCenter.defaultCenter().postNotificationName("tweetNotChanged", object: self)
                completion(tweet: nil, error: error)
                ViewHelpers.showErrorBar("Error retweeting, please try again later.", forDuration: 5)
            }
        })
    }
}