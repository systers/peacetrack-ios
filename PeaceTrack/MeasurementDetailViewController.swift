//
//  MeasurementDetailViewController.swift
//  PeaceTrack
//
//  Created by apple on 8/18/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit

class MeasurementDetailViewController: UIViewController {

    @IBOutlet weak var measurementName: UILabel!
    @IBOutlet weak var measurementCohort: UILabel!
    @IBOutlet weak var measurementOutcome: UILabel!
    @IBOutlet weak var measurementOutcomeData: UILabel!
    @IBOutlet weak var measurementDesc: UILabel!
    
    var name: String = ""
    var cohort: String = ""
    var outcome: String = ""
    var outcomeData: String = ""
    var desc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        measurementName.text = name
        measurementCohort.text = cohort
        measurementOutcome.text = outcome
        measurementOutcomeData.text = outcomeData
        measurementDesc.text = desc
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
