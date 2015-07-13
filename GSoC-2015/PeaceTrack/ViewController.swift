//
//  ViewController.swift
//  PeaceTrack
//
//  Created by apple on 6/26/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        
//        if (isLoggedIn != 1) {
//            self.performSegueWithIdentifier("goto_login", sender: self)
//        } else {
//            self.usernameLabel.text = prefs.valueForKey("USERNAME") as! NSString as String
//        }
    }
    
    @IBAction func logoutTapped(sender: UIButton) {

        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

}

