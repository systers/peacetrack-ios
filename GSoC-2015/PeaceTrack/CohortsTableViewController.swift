//
//  CohortsTableViewController.swift
//  PeaceTrack
//
//  Created by apple on 7/13/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit
import CoreData

class CohortsTableViewController: UITableViewController {

    var foodNames: [String] = ["Food1","Food2","Food3","Food4","Food5","Food6","Food7","Food8"];
    
    
    var cohorts = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Cohort")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        let results = fetchedResults
        
        if (results != nil) {
            cohorts = results!
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        return foodNames.count
        return cohorts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CohortCell", forIndexPath: indexPath) as! UITableViewCell

        let cohort = cohorts[indexPath.row]
        cell.textLabel?.text = cohort.valueForKey("name") as? String

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("cohortDetail", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cohortDetail" {
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            let cohortDetailVC:CohortDetailViewController = segue.destinationViewController as! CohortDetailViewController
            
            let cohort = cohorts[indexPath.row]
//            let name = cohort.valueForKey("name") as? String
//            let description = cohort.valueForKey("description") as? String
//            if (name != nil) {
//                cohortDetailVC.cohortNameLabel?.text = name
//            }
//            if (description != nil) {
//                cohortDetailVC.cohortDescriptionLabel?.text = description
//            }
//            cohortDetailVC.cohort = cohort
            cohortDetailVC.name = (cohort.valueForKey("name") as? String)!
            cohortDetailVC.cohortDescription = (cohort.valueForKey("description") as? String)!
            
        }
    }
}
