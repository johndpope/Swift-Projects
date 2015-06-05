//
//  ViewController.swift
//  Lean On
//
//  Created by Mohan Dhar on 6/2/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer();

    @IBAction func Play(sender: UIBarButtonItem) {
        player.play()
    }
    @IBAction func volumeChange(sender: UISlider) {
        player.volume = volumeOutlet.value
        volumeLabel.text = "\(volumeOutlet.value)"
    }
    @IBAction func Pause(sender: UIBarButtonItem) {
        player.pause()
    }
    @IBAction func Stop(sender: UIBarButtonItem) {
        player.stop()
        player.currentTime = 0;
    }
    @IBOutlet var volumeOutlet: UISlider!
    @IBOutlet var volumeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var audioPath = NSBundle.mainBundle().pathForResource("leanOn", ofType: "mp3")
        
        var error : NSError? = nil
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath!), error: &error)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

