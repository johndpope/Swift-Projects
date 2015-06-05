//
//  ViewController.swift
//  Storing Images
//
//  Created by Mohan Dhar on 6/3/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageViewOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        
        let url = NSURL(string: "http://i.ytimg.com/vi/ReF6iQ7M5_A/maxresdefault.jpg")

        let urlRequest = NSURLRequest(URL: url!);
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            
            response, data, error in
            if error != nil {
                println("There was an error")
            } else {
                
                let image = UIImage(data: data)
                
                //self.imageViewOutlet.image = image;
                
                var documentsDirectory:String?
                
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true);
                
                if paths.count > 0 {
                    documentsDirectory = paths[0] as? String
    
                    var savePath = documentsDirectory! + "/cat.jpg"
                
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                
                    self.imageViewOutlet.image = UIImage(named: savePath)
                }
                
            }
        
        })
*/
        
        
        var documentsDirectory:String?
        
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true);
        
        if paths.count > 0 {
            documentsDirectory = paths[0] as? String
            
            var savePath = documentsDirectory! + "/cat.jpg"
            
            self.imageViewOutlet.image = UIImage(named: savePath)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

