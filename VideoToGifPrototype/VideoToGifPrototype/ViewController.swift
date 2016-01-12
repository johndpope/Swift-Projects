//
//  ViewController.swift
//  VideoToGifPrototype
//
//  Created by Mohan Dhar on 1/11/16.
//  Copyright (c) 2016 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var count = 0;
    var timer: NSTimer?;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func takeScreenshot() {
        UIGraphicsBeginImageContext(self.view.bounds.size);
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext());
        var screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil);
        
        ++count;
        print("\(count)\n");
        
    }
    
    @IBAction func take18ButtonPressed(sender: UIButton) {
        take18Screenshots();
    }
    
    @IBAction func screenshotButtonPressed(sender: UIButton) {
        takeScreenshot();
    }
    
    func take18Screenshots() {
        timer?.invalidate();
        count = 0;
        timer = NSTimer.scheduledTimerWithTimeInterval(0.03333333, target: self, selector: "takeScreenshot", userInfo: nil, repeats: true);
        timer?.fire();
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        timer?.invalidate();
    }
    
    
}

