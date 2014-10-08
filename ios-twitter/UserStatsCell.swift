//
//  UserStatsCell.swift
//  ios-twitter
//
//  Created by sanket patel on 10/5/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class UserStatsCell: UITableViewCell {

    
    @IBOutlet weak var numOfFollowersLabel: UILabel!
    @IBOutlet weak var numOfFollowingLabel: UILabel!
    
    @IBOutlet weak var numOfTweetsLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
