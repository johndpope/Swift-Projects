//
//  ViewController.swift
//  images
//
//  Created by Mohan Dhar on 12/25/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = NSTimer()
    var counter:Int32 = 1;
    @IBOutlet var imageViewOutlet: UIImageView!
    @IBAction func buttonPressed(sender: UIButton) {
        var imageName:String = "frame_00" + String(counter % 8) + ".png";
        let frame2 = UIImage(named: imageName);
        imageViewOutlet.image = frame2;
        ++counter;
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "result", userInfo: nil, repeats: true);
        
    }
    
    func result() {
        if (counter == INT_MAX) {
            counter = 0;
        }
        var imageName:String = "frame_00" + String(counter % 8) + ".png";
        let frame2 = UIImage(named: imageName);
        imageViewOutlet.image = frame2;
        ++counter;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidLayoutSubviews() {
        // imageViewOutlet.frame = CGRectMake(100, 20, 0, 0);
        self.imageViewOutlet.center = CGPointMake(self.imageViewOutlet.center.x - 400, self.imageViewOutlet.center.y);
    }
    
    override func viewDidAppear(animated: Bool) {
        
    
        UIView.animateWithDuration(1, animations: {
            // self.imageViewOutlet.frame = CGRectMake(self.imageViewOutlet.center.x, self.imageViewOutlet.center.y, 100, 200);
        
            self.imageViewOutlet.center = CGPointMake(self.imageViewOutlet.center.x + 400, self.imageViewOutlet.center.y);
        
        })

    }
    
    
}

