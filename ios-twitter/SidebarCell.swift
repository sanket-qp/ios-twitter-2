//
//  SidebarCell.swift
//  ios-twitter
//
//  Created by sanket patel on 10/4/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class SidebarCell: UITableViewCell, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerTextLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellText: UILabel!
    var segue: String?
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTap:")
        tapGestureRecognizer?.delegate = self

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didTap(sender: AnyObject) {
    
    
        println("cell tapped")
    }
}
