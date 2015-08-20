//
//  AddCohortViewController.swift
//  PeaceTrack
//
//  Created by apple on 7/13/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit
import CoreData

class AddCohortViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var members: UITextField!
    @IBOutlet weak var ageFrom: UITextField!
    @IBOutlet weak var ageTo: UITextField!
    @IBOutlet weak var maleMembers: UITextField!
    @IBOutlet weak var femaleMembers: UITextField!
    @IBOutlet weak var commPosition: UITextField!
    @IBOutlet weak var notes: UITextField!
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        self.saveCohort()
        self.saveToServer()
        navigationController?.popViewControllerAnimated(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
    
    }
    
    func saveCohort() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Cohort", inManagedObjectContext: managedContext)
        
        let cohort = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        cohort.setValue(nameTextField.text, forKey: "name")
        cohort.setValue(descriptionTextField.text, forKey: "cohortDescription")
        
        cohort.setValue(members.text, forKey: "cohortMembers")
        
        var ageGroup = ageFrom.text + " - " + ageTo.text
        cohort.setValue(ageGroup, forKey: "cohortAgeGroup")
        cohort.setValue(maleMembers.text, forKey: "cohortMaleMembers")
        cohort.setValue(femaleMembers.text, forKey: "cohortFemaleMembers")
        cohort.setValue(commPosition.text, forKey: "cohortCommPosition")
        cohort.setValue(notes.text, forKey: "cohortNotes")
        
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }
    
    func putCohortToVolunteerList(jsonData: NSDictionary) {
        // set up the base64-encoded credentials
        let username = "admin"
        let password = "mypassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let volunteerId = 1
        
        NSLog("Response ==> %@", jsonData);
        
        // Request URL
        var url:NSURL = NSURL(string: "http://10.2.194.247:8001/api/volunteer/" + String(volunteerId) + "/")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(jsonData, options: nil, error: &err)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var responseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
        
        if ( urlData != nil ) {
            let res = response as! NSHTTPURLResponse!;
            NSLog("Response code: %1d", res.statusCode);
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                NSLog("Response ==> %@", responseData);
                var error: NSError?
//                let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
//                
//                var vol_cohorts:NSMutableArray = jsonData.valueForKey("vol_cohort") as! NSMutableArray
//                vol_cohorts.addObject(id)
//                jsonData.setValue(vol_cohorts, forKey: "vol_cohort")
//                self.postCohortToVolunteerList(jsonData)
                
            } else {
                // Connection failed!
            }
        } else {
        }
        
    }
    
    func getVolunteerDetails(id: NSInteger) {
        
        // set up the base64-encoded credentials
        let username = "admin"
        let password = "mypassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let volunteerId = 1
        
        // Request URL
        var url:NSURL = NSURL(string: "http://10.2.194.247:8001/api/volunteer/" + String(volunteerId) + "/")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var responseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
        
        if ( urlData != nil ) {
            let res = response as! NSHTTPURLResponse!;
            NSLog("Response code: %1d", res.statusCode);
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                NSLog("Response ==> %@", responseData);
                var error: NSError?
                let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
                
                var vol_cohorts:NSMutableArray = jsonData.valueForKey("vol_cohort") as! NSMutableArray
                vol_cohorts.addObject(id)
                jsonData.setValue(vol_cohorts, forKey: "vol_cohort")
                self.putCohortToVolunteerList(jsonData)
                
            } else {
                // Connection failed!
            }
        } else {
        }

        
    }
    
    func saveToServer() {
        // set up the base64-encoded credentials
        let username = "admin"
        let password = "mypassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)

        // Request URL
        var url:NSURL = NSURL(string: "http://10.2.194.247:8001/api/cohort/")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        var params = ["cohort_name":"jameson", "cohort_desc":"password", "cohort_no_of_members":127, "cohort_age":"23", "cohort_males": 231, "cohort_females": 705, "cohort_pos": "positions", "cohort_notes": "notes"] as Dictionary<String, AnyObject>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        var responseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
        
        if ( urlData != nil ) {
            let res = response as! NSHTTPURLResponse!;
            NSLog("Response code: %1d", res.statusCode);
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                NSLog("Response ==> %@", responseData);
                var error: NSError?
                let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
                let id:NSInteger = jsonData.valueForKey("id") as! NSInteger
                NSLog("Success: %ld", id);
                self.getVolunteerDetails(id)
            } else {
                // Connection failed!
            }
        } else {
        }

    }
   
}
