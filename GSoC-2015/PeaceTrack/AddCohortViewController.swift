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
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        self.saveCohort(nameTextField.text, description: descriptionTextField.text)
        navigationController?.popViewControllerAnimated(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
    
    }
    
    func saveCohort(name: String, description: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Cohort", inManagedObjectContext: managedContext)
        
        let cohort = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        cohort.setValue(name, forKey: "name")
        cohort.setValue(description, forKey: "cohortDescription")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }
   
}
