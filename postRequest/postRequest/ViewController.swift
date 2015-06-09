//
//  ViewController.swift
//  postRequest
//
//  Created by Mohan Dhar on 6/9/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import SwiftyJSON

class GEOIP {
    var isp:String
    var longitude:Double
    var latitude:Double
    var area_code:String
    var country:String
    var country_code3:String
    var dma_code:String
    var asn:String
    var continent_code:String
    var ip:String
    var country_code:String
    
    init () {
        
        self.isp = ""
        self.longitude = 0.0
        self.latitude = 0.0
        self.area_code = ""
        self.country = ""
        self.country_code3 = ""
        self.dma_code = ""
        self.asn = ""
        self.continent_code = ""
        self.ip = ""
        self.country_code = ""
    }
    init (jsonObj: JSON) {
        self.isp = jsonObj["isp"].string!
        self.longitude = jsonObj["longitude"].doubleValue
        self.latitude = jsonObj["latitude"].doubleValue
        self.area_code = jsonObj["area_code"].string!
        self.country = jsonObj["country"].string!
        self.country_code3 = jsonObj["country_code3"].string!
        self.dma_code = jsonObj["dma_code"].string!
        self.asn = jsonObj["asn"].string!
        self.continent_code = jsonObj["continent_code"].string!
        self.ip = jsonObj["ip"].string!
        self.country_code = jsonObj["country_code"].string!
    }
}

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        let httpMethod = "POST"
        
        /* We have a 15-second timeout for our connection */
        let timeout = 15
        
        /* Set URL */
        var urlAsString = "http://www.telize.com/geoip"
        
        /* These are the parameters that will be sent as part of the URL */
        urlAsString += "?param1=First"
        urlAsString += "&param2=Second"
        
        let url = NSURL(string: urlAsString)
        
        /* Set the timeout on our request here */
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
        
        urlRequest.HTTPMethod = httpMethod
        
        /* These are the POST parameters */
        
        let body = "bodyParam1=BodyValue1&bodyParam2=BodyValue2".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        urlRequest.HTTPBody = body
        
        let queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {(response: NSURLResponse!,
            data: NSData!, error: NSError!) in
            
         /* Now we may have access to the data, but check if an error comes back first or not */
            if data.length > 0 && error == nil {
                let json = JSON(data: data)
                println(json)
                println("JSON OBJECT IS WORKING")
                println("----------------------")
                let obj = GEOIP(jsonObj: json)
                println(obj)
                println("OBJECT FROM JSON IS WORKING")
                println("---------------------------")
                

                var destination:DataViewController = self.storyboard?.instantiateViewControllerWithIdentifier("data") as! DataViewController
                destination.obj = obj
                self.presentViewController(destination, animated: true, completion: nil)
                self.dismissViewControllerAnimated(false, completion: nil)
                
                
            } else if data.length == 0 && error == nil {
                println("Nothing was downloaded")
            } else if error != nil {
                println("Error happened = \(error)")
            }
            
        })
    }

}

