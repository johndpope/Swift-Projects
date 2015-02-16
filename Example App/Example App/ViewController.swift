//
//  ViewController.swift
//  Example App
//
//  Created by Mohan Dhar on 12/21/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonPressed(sender: UIButton) {
        myLabel.text = "My name is Mohan";
    }
    @IBOutlet var myButton: UIButton!
    @IBOutlet var myLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("Hello World!");
        
        myLabel.text = "It worked!";
        myButton.setTitle("Click Me!", forState: nil);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

