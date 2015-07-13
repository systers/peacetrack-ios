//
//  CohortDetailViewController.swift
//  PeaceTrack
//
//  Created by apple on 7/13/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit
import CoreData

class CohortDetailViewController: UIViewController {

    
    @IBOutlet weak var cohortNameLabel: UILabel!
    @IBOutlet weak var cohortDescriptionLabel: UILabel!
    
//    var cohort = NSManagedObject()
    var name: String = ""
    var cohortDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cohortNameLabel.text = name
        cohortDescriptionLabel.text = cohortDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteCohortTapped(sender: AnyObject) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
