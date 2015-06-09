//
//  DataViewController.swift
//  postRequest
//
//  Created by Mohan Dhar on 6/9/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataViewController: UIViewController {
    
    var obj:GEOIP!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println("-----------------------------------------------------")
        println(obj.isp)
        println(obj.longitude)
        println(obj.latitude)
        println(obj.area_code)
        println(obj.country)
        println(obj.country_code3)
        println(obj.dma_code)
        println(obj.asn)
        println(obj.continent_code)
        println(obj.ip)
        println(obj.country_code)
        println("Success!!!")
        println("Now, Let's convert this back to a JSON Object!!!")
        
        var dict = [
            "isp": obj.isp,
            "longitude": obj.longitude,
            "latitude": obj.latitude,
            "area code": obj.area_code,
            "country": obj.country,
            "country code3": obj.country_code3,
            "dma code": obj.dma_code,
            "asn": obj.asn,
            "continent code": obj.continent_code,
            "ip": obj.ip,
            "country code": obj.country_code
        
        ]
        var jsonObj = JSON(dict)
        println(jsonObj)
        println("Well done Mohan, well done.")

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
