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
    
    @IBOutlet weak var cohortMembers: UILabel!
    @IBOutlet weak var cohortAgeGroup: UILabel!
    @IBOutlet weak var cohortMales: UILabel!
    @IBOutlet weak var cohortFemales: UILabel!
    @IBOutlet weak var cohortPosition: UILabel!
    @IBOutlet weak var cohortNotes: UILabel!
//    var cohort = NSManagedObject()
    var name: String = ""
    var cohortDescription: String = ""
    var members: String = ""
    var ageGroup: String = ""
    var males: String = ""
    var females: String = ""
    var position: String = ""
    var notes: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cohortNameLabel.text = name
        cohortDescriptionLabel.text = cohortDescription
        cohortAgeGroup.text = ageGroup
        cohortMales.text = males
        cohortFemales.text = females
        cohortPosition.text = position
        cohortNotes.text = notes
        cohortMembers.text = members
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
