//
//  ViewController.swift
//  How Many Fingers
//
//  Created by Mohan Dhar on 12/21/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var correctLabel: UILabel!
    @IBOutlet var stepperOutlet: UIStepper!
    @IBOutlet var guessCount: UILabel!
    
    var randomNum = 0;
    var turns = 0;
    var score = 0;
    
    @IBAction func stepperChanged(sender: UIStepper) {
        guessCount.text = String(Int(stepperOutlet.value));
    }
    @IBAction func lockedIn(sender: UIButton) {
        println("It was a \(randomNum)");
        ++turns;
        var currentGuess = Int(stepperOutlet.value);
        if (currentGuess-1 == randomNum) {
            correctLabel.text = "Correct!";
            correctLabel.textColor = UIColor.orangeColor();
            ++score;
        } else {
            correctLabel.text = "Incorrect\nTry Again.";
            correctLabel.textColor = UIColor.whiteColor();
        }
        scoreLabel.text = "\(score)/\(turns)";
        randomNum = Int(arc4random_uniform(5));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomNum = Int(arc4random_uniform(5));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

