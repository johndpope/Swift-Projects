//
//  ViewController.swift
//  Cat Years
//
//  Created by Mohan Dhar on 12/21/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var catYearsLabel: UILabel!
    @IBAction func findAge(sender: UIButton){
        var age = ageTextField.text.toInt();
        if (age != nil) {
            var catYears = age! * 7;
            catYearsLabel.text = "Your cat is \(catYears) in cat years";
            println(catYears);
        } else {
            catYearsLabel.text = "Please enter a number in the box";
        }
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

