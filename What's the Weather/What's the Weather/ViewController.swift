//
//  ViewController.swift
//  What's the Weather
//
//  Created by Mohan Dhar on 12/25/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityOutlet: UITextField!
    @IBOutlet var weatherOutlet: UILabel!
    @IBAction func findWeather(sender: UIButton) {
        var city = cityOutlet.text;
        self.view.endEditing(true);
        
        var modifiedCity = "";
        for (index, i) in enumerate(city) {
            if (i == " ") {
                modifiedCity += "-";
            } else {
                modifiedCity += String(i);
            }
        }
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/"
            + modifiedCity + "/forecasts/latest");
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            // println(NSString(data: data, encoding: NSUTF8StringEncoding));
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding);
            let tempUrlContent:String = urlContent as String;
            
            
            if (urlContent!.containsString("<span class=\"phrase\">")) {
            var arrayContent = urlContent!.componentsSeparatedByString("span class=\"phrase\">");
            println(arrayContent);
            var newArrayContent = arrayContent[1].componentsSeparatedByString("</span>");
            // println(newArrayContent[0]);
            self.weatherOutlet.text = newArrayContent[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") as String;
            } else {
                self.weatherOutlet.text = "Unable to find City. Please try again.";
            }

        }
        
    
        task.resume();
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

