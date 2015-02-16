//
//  ViewController.swift
//  Is it Prime
//
//  Created by Mohan Dhar on 12/22/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var numberOutlet: UITextField!
    @IBOutlet var primeLabel: UILabel!
    
    @IBAction func checkIfPrime(sender: UIButton) {
        var enteredNumber = numberOutlet.text.toInt();
        var squareRoot = sqrt(Double(enteredNumber!));
        if (enteredNumber != nil && enteredNumber > 1) {
            var prime = true;
            for (var i = 2; Double(i) <= squareRoot; ++i) {
                println("i is: \(i)");
                if (enteredNumber! % i == 0) {
                    prime = false;
                    break;
                }
            }
            if (prime) {
                primeLabel.text = "The number is prime!";
            }
            else {
                primeLabel.text = "The number is not prime.";
            }
        }
        else {
            primeLabel.text = "Enter a number greater than 1";
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

