//
//  ViewController.swift
//  BlurrySideBar
//
//  Created by Mohan Dhar on 6/8/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideBarDelegate {

    @IBOutlet var imageViewOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let sideBar = SideBar(sourceView: self.view, menuItems: ["Cyndaquil", "Quilava", "Typhlosion"])
        
        sideBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0 {
            imageViewOutlet.image = UIImage(named: "cyndaquil.png")
        } else if index == 1 {
//            let url = NSURL(string: "http://pngimg.com/upload/cat_PNG1631.png")
//            let data = NSData(contentsOfURL: url!)
//            imageViewOutlet.image = UIImage(data: data!)
            imageViewOutlet.image = UIImage(named: "quilava.png")
        }
        else if index == 2 {
            imageViewOutlet.image = UIImage(named: "typhlosion.png")
        }
    }
    
}

