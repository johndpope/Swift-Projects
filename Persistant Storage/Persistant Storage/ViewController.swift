//
//  ViewController.swift
//  Persistant Storage
//
//  Created by Mohan Dhar on 12/23/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Saving
        //NSUserDefaults.standardUserDefaults().setObject("Mohan", forKey: "myName");
        //NSUserDefaults.standardUserDefaults().synchronize();
        
        //Opening
        println(NSUserDefaults.standardUserDefaults().objectForKey("myName"));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

