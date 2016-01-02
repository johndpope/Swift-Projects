//
//  ViewController.swift
//  Test Image
//
//  Created by Mohan Dhar on 7/12/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        imageView = UIImageView(frame: CGRectMake(view.center.x, view.center.y, 200, 200))
        self.view.addSubview(imageView!)
        print("Success")
        imageView!.image = UIImage(named: "person")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

