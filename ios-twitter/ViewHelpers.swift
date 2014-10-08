//
//  ViewHelpers.swift
//  ios-twitter
//
//  Created by sanket patel on 9/28/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
class ViewHelpers {



    class func showProgress(view: UIView, text: String = "Loading") {
        
        let loading = MBProgressHUD.showHUDAddedTo(view, animated: true)
        loading.mode = MBProgressHUDModeCustomView
        loading.labelText = "\(text)"
    }

    class func dismissProgress(view: UIView) {
    
         MBProgressHUD.hideAllHUDsForView(view, animated: true)
    }
    
    class func showErrorBar(errorMessage: String, forDuration: Int = 10) {
    
        let notification = CWStatusBarNotification()
        notification.notificationLabelBackgroundColor = .orangeColor()
        notification.displayNotificationWithMessage(errorMessage, forDuration: 10)
    }
    

}