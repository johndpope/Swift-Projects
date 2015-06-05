//
//  ViewController.swift
//  Audio
//
//  Created by Mohan Dhar on 6/2/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()


    @IBAction func Play(sender: UIButton) {
        var audioPath = NSBundle.mainBundle().pathForResource("leanOn", ofType: "mp3")!
        
        var error: NSError? = nil;
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error);
        
        if (error == nil) {
            player.play();
        } else {
            println(error);
        }
        
    }
    @IBAction func Pause(sender: UIButton) {
        player.pause();
    }
    @IBAction func sliderChanged(sender: UISlider) {
        player.volume = sliderOutlet.value;
    }
    
    @IBOutlet var sliderOutlet: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

