//
//  ActivityDetailViewController.swift
//  PeaceTrack
//
//  Created by apple on 8/18/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityCohort: UILabel!
    @IBOutlet weak var activityOutput: UILabel!
    @IBOutlet weak var activityDate: UILabel!
    @IBOutlet weak var activityDesc: UILabel!
    
    var name: String = ""
    var cohort: String = ""
    var output: String = ""
    var date: String = ""
    var desc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityName.text = name
        activityCohort.text = cohort
        activityOutput.text = output
        activityDate.text = date
        activityDesc.text = desc

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
