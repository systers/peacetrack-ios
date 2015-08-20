//
//  LoginViewController.swift
//  PeaceTrack
//
//  Created by apple on 6/26/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate {
    
//    var post: [String] = []
    var posts: [[String:String]] = []
    
    
    var sectors: [[String:String]] = []
    
    func getPosts() {
        // set up the base64-encoded credentials
        let username = "admin"
        let password = "mypassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        // Request URL
        var url:NSURL = NSURL(string: "http://10.2.194.247:8001/api/ptposts/?format=json")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
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
                let count:NSInteger = jsonData.valueForKey("count") as! NSInteger
                NSLog("Success: %ld", count);
                let results:NSArray = jsonData.valueForKey("results") as! NSArray
               
                for result in results {
                    var fResult:String = result.valueForKey("post_name") as! String
                    var fId:NSInteger = result.valueForKey("id") as! NSInteger
                    var fIdString = String(fId)
                    
                    var postDict = ["post_name": fResult, "id": fIdString]
                    posts.append(postDict)
//                    post.append(fResult as String)
                    NSLog("Post ==> %@", fResult);
                }
            } else {
                // Connection failed!
            }
        } else {
        }
        
    }
    
    func getSectors(id: String) {
        // set up the base64-encoded credentials
        let username = "admin"
        let password = "mypassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        // Request URL
        var url:NSURL = NSURL(string: "http://10.2.194.247:8001/api/ptposts/?post_sectors=True&id=" + id + "&format=json")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
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
                let count:NSInteger = jsonData.valueForKey("count") as! NSInteger
                NSLog("Success: %ld", count);
                let results:NSArray = jsonData.valueForKey("results") as! NSArray
                
                for result in results {
                    var fResult:String = result.valueForKey("sector_name") as! String
                    var fId:NSInteger = result.valueForKey("id") as! NSInteger
                    var fIdString = String(fId)
                    
                    var sectorDict = ["sector_name": fResult, "id": fIdString]
                    sectors.append(sectorDict)
                    NSLog("Sector ==> %@", fResult);
                }
            } else {
                // Connection failed!
            }
        } else {
        }
        
    }

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var sectorTextField: UITextField!

    // Here Password === Email
    @IBOutlet weak var txtPassword: UITextField!
    
    var pickerViewType = ""
    
    
    @IBAction func selectPost(sender: UITextField) {
    if(sender.restorationIdentifier=="postSelectField") {
            pickerViewType = "post"
            var postPickerView = UIPickerView()
            postPickerView.delegate = self
            postTextField.inputView = postPickerView
        }
    }
    
    @IBAction func selectSector(sender: UITextField) {
    if(sender.restorationIdentifier=="sectorSelectField") {
            pickerViewType = "sector"
            var sectorPickerView = UIPickerView()
            sectorPickerView.delegate = self
            sectorTextField.inputView = sectorPickerView
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinTapped(sender: UIButton) {
        self.volunteerValidate()
    }
    
    func volunteerValidate() {
        // set up the base64-encoded credentials
        let username = "admin"
        let password = "mypassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        var postId:String = ""
        var sectorId:String = ""
        for dict in posts {
            if(dict["post_name"] == postTextField.text) {
                postId = dict["id"]!
                break
            }
        }
        for dict in sectors {
            if(dict["sector_name"] == sectorTextField.text) {
                sectorId = dict["id"]!
                break
            }
        }
        
        let name = txtUsername.text.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: nil, range: nil)
        let email = txtPassword.text
        let pID = postId
        let sID = sectorId
        
        let finalURL = "http://10.2.194.247:8001/api/volunteer/?format=json&vol_name=\(name)&vol_email=\(email)&vol_ptpost=\(pID)&vol_sector=\(sID)"
        
        NSLog("URL String: %@", finalURL);
        
        // Request URL
        var url:NSURL = NSURL(string: finalURL)!
        
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
                let count:NSInteger = jsonData.valueForKey("count") as! NSInteger
                NSLog("Success: %ld", count);
                let results:NSArray = jsonData.valueForKey("results") as! NSArray
                
                for result in results {
                    var volunteerId:NSInteger = result.valueForKey("id") as! NSInteger
                    var volunteerIdString = String(volunteerId)
                    
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.setInteger(volunteerId, forKey: "USERID")
                    navigationController?.popViewControllerAnimated(true)
                }

                
            } else {
                // Connection failed!
            }
        } else {
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // PickerView Post data Delegate functions 
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        if (pickerViewType == "post") {
            return posts.count
        } else {
            return sectors.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerViewType == "post") {
            return posts[row]["post_name"]
        } else {
            return sectors[row]["sector_name"]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerViewType=="post") {
            postTextField.text = posts[row]["post_name"]
            sectors.removeAll(keepCapacity: false)
            getSectors(posts[row]["id"]!)
        } else {
            sectorTextField.text = sectors[row]["sector_name"]
        }
    }
}
