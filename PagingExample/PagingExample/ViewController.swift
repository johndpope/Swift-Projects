//
//  ViewController.swift
//  PagingExample
//
//  Created by Mohan Dhar on 9/24/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView1: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView1.pagingEnabled = true;
        setup();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        // Frame
        self.scrollView1.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView1.frame.width
        let scrollViewHeight:CGFloat = self.scrollView1.frame.height


        // View
        let black = UIView(frame: CGRectMake(0, 0, scrollViewWidth, scrollViewHeight));
        black.backgroundColor = UIColor.blackColor();
        let red = UIImageView(frame: CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight));
        red.backgroundColor = UIColor.redColor();
        let blue = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0, scrollViewWidth, scrollViewHeight));
        blue.backgroundColor = UIColor.blueColor();

        
        self.scrollView1.addSubview(black);
        self.scrollView1.addSubview(red);
        self.scrollView1.addSubview(blue);

        // Content Size
        self.scrollView1.contentSize = CGSizeMake(self.scrollView1.frame.width * 3, self.scrollView1.frame.height)
        self.scrollView1.contentOffset = CGPointMake(self.scrollView1.frame.width, 0);
        self.scrollView1.delegate = self

        
        
    }


}

