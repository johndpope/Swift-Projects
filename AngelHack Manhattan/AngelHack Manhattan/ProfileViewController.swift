//
//  ProfileViewController.swift
//  AngelHack Manhattan
//
//  Created by Mohan Dhar on 7/11/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    

    @IBOutlet var photo: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var occupation: UILabel!
    
    @IBOutlet var companyOrSchool: UILabel!
    
    @IBOutlet var phoneNumber: UILabel!
    
    @IBOutlet var email: UILabel!
    
    @IBOutlet var website: UILabel!
    
    @IBOutlet var linkedIn: UILabel!
    
    @IBOutlet var twitter: UILabel!
    
    @IBOutlet var github: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImage() {
        let userPhoto = UIImage(named: "person")
        self.photo.image = userPhoto
        self.photo.layer.cornerRadius = self.photo.frame.size.height / 2
        self.photo.clipsToBounds = true
        
    }
    
    @IBAction func unwindToProfile(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditViewController {
            print("Success", appendNewline: false)
        }
    }


}

