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
        
        print("-----------------------------------------------------")
        print(obj.isp)
        print(obj.longitude)
        print(obj.latitude)
        print(obj.area_code)
        print(obj.country)
        print(obj.country_code3)
        print(obj.dma_code)
        print(obj.asn)
        print(obj.continent_code)
        print(obj.ip)
        print(obj.country_code)
        print("Success!!!")
        print("Now, Let's convert this back to a JSON Object!!!")
        
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
        print(jsonObj)
        print("Well done Mohan, well done.")

        
        
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
