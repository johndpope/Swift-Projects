//
//  ViewController.swift
//  GET Request
//
//  Created by Mohan Dhar on 10/6/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let network = Network();
    var filePath: NSURL?
    var player = AVAudioPlayer?();


    @IBOutlet var urlField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playMp3(sender: UIButton) {
        
        if let path = filePath {
            do {
                try player = AVAudioPlayer(contentsOfURL: path)
                player!.play();
            } catch {
                print("Player not available")
            }
        }
    }

    @IBAction func downloadMp3ButtonPressed(sender: UIButton) {
        let youtubeUrl = urlField.text;
        if let youtubeUrl = youtubeUrl {
            network.makeGetRequest(youtubeUrl, jsonHandler: {
                (data) -> Void in
                if let data = data {
                    if let link = data["link"] as? String {
                        if let url = NSURL(string: link) {
                            
                            
                            if let audioUrl = NSURL(string: link) {
                                // create your document folder url
                                let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
                                // your destination file url
                                let destinationUrl = documentsUrl!.URLByAppendingPathComponent((data["title"] as! String) + ".mp3");
                                print(destinationUrl)
                                // check if it exists before downloading it
                                if NSFileManager().fileExistsAtPath(destinationUrl.path!) {
                                    print("The file already exists at path")
                                } else {
                                    //  if the file doesn't exist
                                    //  just download the data from your url
                                    if let myAudioDataFromUrl = NSData(contentsOfURL: audioUrl){
                                        // after downloading your data you need to save it to your destination url
                                        if myAudioDataFromUrl.writeToURL(destinationUrl, atomically: true) {
                                            print("file saved")
                                            self.filePath = destinationUrl;
                                        } else {
                                            print("error saving file")
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
            })
        }
    }


}

