//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Mohan Dhar on 6/2/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
 
    var sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep9", ofType: "mp3")!)
    
    var player = AVAudioPlayer();
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (event.subtype == UIEventSubtype.MotionShake) {
            
            player = try? AVAudioPlayer(contentsOfURL: sound);
            player.play();
            
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

