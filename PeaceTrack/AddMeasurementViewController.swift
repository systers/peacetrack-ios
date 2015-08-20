//
//  AddMeasurementViewController.swift
//  PeaceTrack
//
//  Created by apple on 8/18/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit
import CoreData

class AddMeasurementViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var measurementName: UITextField!
    @IBOutlet weak var measurementDesc: UITextField!
    @IBOutlet weak var cohortSelectTextField: UITextField!
    @IBOutlet weak var outcomeSelectTextField: UITextField!
    @IBOutlet weak var outcomeData: UITextField!
    
    
    var cohortOptions = [String]()
    var outcomeOptions = ["Outcome1", "Outcome2", "Outcome3", "Outcome4"]
    var cohorts = [NSManagedObject]()
    var pickerViewType = ""
    
    @IBAction func cohortOptionsSelect(sender: UITextField) {
        if(sender.restorationIdentifier=="cohortSelectField") {
            pickerViewType = "cohort"
            var cohortPickerView = UIPickerView()
            cohortPickerView.delegate = self
            cohortSelectTextField.inputView = cohortPickerView
        }
    }
    
    @IBAction func outcomeOptionsSelect(sender: UITextField) {
        
    if(sender.restorationIdentifier=="outcomeSelectField") {
            pickerViewType = "outcome"
            var outcomePickerView = UIPickerView()
            outcomePickerView.delegate = self
            outcomeSelectTextField.inputView = outcomePickerView
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Cohort")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        let results = fetchedResults
        
        cohortOptions.removeAll(keepCapacity: false);
        if (results != nil) {
            cohorts = results!
            for (var i=0;i<cohorts.count;i++) {
                cohortOptions.append((cohorts[i].valueForKey("name") as? String)!)
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerViewType=="cohort") {
            return cohortOptions.count
        } else {
            return outcomeOptions.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerViewType=="cohort") {
            return cohortOptions[row]
        } else {
            return outcomeOptions[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerViewType=="cohort") {
            cohortSelectTextField.text = cohortOptions[row]
        } else {
            outcomeSelectTextField.text = outcomeOptions[row]
        }
    }
    

    @IBAction func measurementSaveTapped(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Measurement", inManagedObjectContext: managedContext)
        
        let measurement = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        measurement.setValue(measurementName.text, forKey: "name")
        measurement.setValue(measurementDesc.text, forKey: "measurementDescription")
        measurement.setValue(cohortSelectTextField.text, forKey: "measurementCohort")
        measurement.setValue(outcomeSelectTextField.text, forKey: "measurementOutcome")
        measurement.setValue(outcomeData.text, forKey: "outcomeData")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        navigationController?.popViewControllerAnimated(true)
        
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
