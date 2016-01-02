//
//  ViewController.swift
//  ShakeAndSwipe
//
//  Created by Mohan Dhar on 6/2/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.view.addGestureRecognizer(swipeRight);
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up;
        self.view.addGestureRecognizer(swipeUp);
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down;
        self.view.addGestureRecognizer(swipeDown);
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        self.view.addGestureRecognizer(swipeLeft);
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (event!.subtype == UIEventSubtype.MotionShake) {
            
            print("User Shook Their Device");
            
        }
    }
    
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch (swipeGesture.direction) {
                
                case UISwipeGestureRecognizerDirection.Right:
                    print("User swiped Right");
                
                case UISwipeGestureRecognizerDirection.Up:
                    print("User swiped Up");
                
                case UISwipeGestureRecognizerDirection.Down:
                    print("User swiped Down")
                
                case UISwipeGestureRecognizerDirection.Left:
                    print("User Swiped Left");
                
                default:
                    break;
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

