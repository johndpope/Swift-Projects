//
//  ViewController.swift
//  JSON Demo
//
//  Created by Mohan Dhar on 6/3/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://www.telize.com/geoip")
        let urlRequest = NSURLRequest(URL: url!);
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            
            (response, data, error) in
            if error != nil {
                print(error)
            } else {
                var jsonResult: AnyObject?
                do {
                    jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                } catch _ {
                    jsonResult = nil
                }
                
                if (jsonResult == nil) {
                    print("No Json Object found!")
                }
                //print(jsonResult)
                let obj = jsonResult as! NSDictionary
                
                let attr = obj["ip"] as! String
                print(attr)
            }
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

