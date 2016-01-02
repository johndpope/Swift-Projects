//
//  Network.swift
//  GET Request
//
//  Created by Mohan Dhar on 10/6/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import Foundation

class Network : NSObject {
    // Must make sure we include NSAppTransportSecurity (Dictionary) in info.plist
    // Make NSAllowsArbitraryLoads as a subcategory (Boolean) and make the value YES
    
    override init() {
        super.init();
    }
    
    
    func makeGetRequest( youtubeURL: String, jsonHandler : (jsonObject : NSDictionary?) -> Void) {
        // Create a network session to get data from the API
        let session = NSURLSession.sharedSession();
        
    // If a comic already exists, do nothing
        let url =  NSURL(string: "http://youtubeinmp3.com/fetch/?api=advanced&format=JSON&video=\(youtubeURL)");
        let getApiData = session.dataTaskWithURL(url!, completionHandler: {
            
            (data, response, error) -> Void in
            
            if (error == nil) {
                print("We got data!");
                
                var jsonObject : NSDictionary?
                
                // Make sure we can convert the bytes to JSON
                do {
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                    // Success
                    jsonHandler(jsonObject: jsonObject);
                } catch {
                    // Failure to convert from bytes to JSON
                    print("Data to JSON Failed");
                }
                
            } else {
                // Failure in the network call
                print("There was an error");
            }
        })
        getApiData.resume();
    }
}
