//
//  ViewController.swift
//  Timer
//
//  Created by Mohan Dhar on 12/22/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()
    var currentSec = 0;
    var isOn = false;
    @IBOutlet var timerLabel: UILabel!
    
    @IBAction func resetTimer(sender: UIBarButtonItem) {
        timer.invalidate();
        isOn = false;
        currentSec = 0;
        timerLabel.text = "0";
    }
    
    
    @IBAction func startTimer(sender: UIBarButtonItem) {
        if (!isOn) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1,
                target: self,
                selector: Selector("changeTime"),
                userInfo: nil, repeats: true);
            isOn = true;
        }
    }
    func changeTime() {
        currentSec++;
        timerLabel.text = String(currentSec);
    }
    @IBAction func pauseTimer(sender: UIBarButtonItem) {
        timer.invalidate();
        isOn = false;
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

