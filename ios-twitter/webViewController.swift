//
//  webViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class webViewController: UIViewController {

    var destination: String! = nil
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccess:" , name: "loginSuccess", object: nil)

        if destination != nil {
        
            let url = NSURL(string: destination)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginSuccess(sender: AnyObject) {
        
        self.performSegueWithIdentifier("newHomeSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("preparing for timeline segue")
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)

    }

}
