//
//  EditViewController.swift
//  AngelHack Manhattan
//
//  Created by Mohan Dhar on 7/11/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet var editPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.editPhoto.layer.cornerRadius = self.editPhoto.frame.height / 2
        self.editPhoto.clipsToBounds = true;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
