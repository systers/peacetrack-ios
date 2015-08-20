//
//  AddActivityViewController.swift
//  PeaceTrack
//
//  Created by apple on 8/15/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit
import CoreData

class AddActivityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var activityName: UITextField!
    @IBOutlet weak var activityDesc: UITextField!
//    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addDate: UITextField!
    
    @IBOutlet weak var cohortSelectTextField: UITextField!
    
    @IBOutlet weak var outputSelectTextField: UITextField!
    
    var cohortOptions = [String]()
    var outputOptions = ["Output1", "Output2", "Output3", "Output4"]
    var cohorts = [NSManagedObject]()
    var pickerViewType = ""
    
    @IBAction func dateFieldEditing(sender: UITextField) {
        
        if(sender.restorationIdentifier=="addDateField") {
        
            var datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    @IBAction func outputOptionsEditing(sender: UITextField) {
    if(sender.restorationIdentifier=="outputSelectField") {
            pickerViewType = "output"
            var outputPickerView = UIPickerView()
            outputPickerView.delegate = self
            outputSelectTextField.inputView = outputPickerView
        }
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        addDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func cohortOptionsEditing(sender: UITextField) {
        
        if(sender.restorationIdentifier=="cohortSelectField") {
            pickerViewType = "cohort"
            var cohortPickerView = UIPickerView()
            cohortPickerView.delegate = self
            cohortSelectTextField.inputView = cohortPickerView
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerViewType=="cohort") {
            return cohortOptions.count
        } else {
            return outputOptions.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerViewType=="cohort") {
            return cohortOptions[row]
        } else {
            return outputOptions[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerViewType=="cohort") {
            cohortSelectTextField.text = cohortOptions[row]
        } else {
            outputSelectTextField.text = outputOptions[row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveActivityTapped(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Activity", inManagedObjectContext: managedContext)
        
        let activity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        activity.setValue(activityName.text, forKey: "name")
        activity.setValue(activityDesc.text, forKey: "activityDescription")
        activity.setValue(cohortSelectTextField.text, forKey: "activityCohort")
        activity.setValue(outputSelectTextField.text, forKey: "activityOutput")
        activity.setValue(addDate.text, forKey: "activityDate")
        
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