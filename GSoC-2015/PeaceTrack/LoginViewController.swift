//
//  LoginViewController.swift
//  PeaceTrack
//
//  Created by apple on 6/26/15.
//  Copyright (c) 2015 Systers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate {
    
    var post: [String] = []
    var sector: [String] = []
    
    func getPosts() {
        // set up the base64-encoded credentials
        let username = "vennela-miryala"
        let password = "abcdef12345"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        // Request URL
        var url:NSURL = NSURL(string: "http://54.183.13.103/api/ptposts/?format=json")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var responseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
        
        if ( urlData != nil ) {
            let res = response as NSHTTPURLResponse!;
            NSLog("Response code: %1d", res.statusCode);
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                NSLog("Response ==> %@", responseData);
                var error: NSError?
                let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                let count:NSInteger = jsonData.valueForKey("count") as NSInteger
                NSLog("Success: %ld", count);
                let results:NSArray = jsonData.valueForKey("results") as NSArray
               
                for result in results {
                    var fResult:NSString = result.valueForKey("post_name") as NSString
                    post.append(fResult)
                    NSLog("Post ==> %@", fResult);
                }
            } else {
                // Connection failed!
            }
        } else {
        }
        
    }
    
    func getSectors() {
        // set up the base64-encoded credentials
        let username = "vennela-miryala"
        let password = "abcdef12345"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        // Request URL
        var url:NSURL = NSURL(string: "http://54.183.13.103/api/sectors/?format=json")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var responseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
        
        if ( urlData != nil ) {
            let res = response as NSHTTPURLResponse!;
            NSLog("Response code: %1d", res.statusCode);
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                NSLog("Response ==> %@", responseData);
                var error: NSError?
                let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                let count:NSInteger = jsonData.valueForKey("count") as NSInteger
                NSLog("Success: %ld", count);
                let results:NSArray = jsonData.valueForKey("results") as NSArray
                
                for result in results {
                    var fResult:NSString = result.valueForKey("sector_name") as NSString
                    sector.append(fResult)
                    NSLog("Sector ==> %@", fResult);
                }
            } else {
                // Connection failed!
            }
        } else {
        }
        
    }

    @IBOutlet weak var txtUsername: UITextField!
    

    // Here Password === Email
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPosts()
        getSectors()
    }   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinTapped(sender: UIButton) {

        self.dismissViewControllerAnimated(true, completion: nil)
        // Authentication code

/*
        var username:NSString = txtUsername.text
        var password:NSString = txtPassword.text
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter all details"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            var post:NSString = "username=\(username)&password=\(password)"
            
            NSLog("PostData: %@", post);
            
            // Request URL
            var url:NSURL = NSURL(string: "https://dipinkrishna.com/jsonlogin2.php")!
            
            var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            var postLength: NSString = String( postData.length )
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var responseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
            
            if ( urlData != nil ) {
                let res = response as NSHTTPURLResponse!;
                
                NSLog("Response code: %1d", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                    
                    let success:NSInteger = jsonData.valueForKey("success") as NSInteger
                    
                    NSLog("Success: %1d", success);
                    
                    if(success == 1) {
                        NSLog("Login SUCCESS");
                        
                        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        prefs.setObject(username, forKey: "USERNAME")
                        prefs.setInteger(1, forKey: "ISLOGGEDIN")
                        prefs.synchronize()
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        var error_msg: NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = error_msg
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else {
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = responseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
*/
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
        if (pickerView.tag == 0) {
            return post.count
        } else {
            return sector.count
        }
    }
    
//    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
//        if (pickerView.tag == 0) {
//            return post[row]
//        } else {
//            return sector[row]
//        }
//    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        var pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        if (pickerView.tag == 0) {
            pickerLabel.text = post[row]
        } else {
            pickerLabel.text = sector[row]
        }
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 15) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }

}
