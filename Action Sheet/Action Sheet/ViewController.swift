//
//  ViewController.swift
//  Action Sheet
//
//  Created by Mohan Dhar on 6/8/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var controller:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        controller = UIAlertController(title: "ALERT ALERT ALERT", message: "This is an alert controller", preferredStyle: UIAlertControllerStyle.Alert)
        
        let action = UIAlertAction(title: "CLICK OK", style: UIAlertActionStyle.Default, handler: { (paramAction:UIAlertAction!) in
            println("Some Action")
        })
        
        controller!.addAction(action)
        controller?.addTextFieldWithConfigurationHandler( {(textfield:UITextField!) in
            textfield.placeholder = "XXXXXXXXXX"
        })
        
        let action1 = UIAlertAction(title: "Get Text From Textfield", style: UIAlertActionStyle.Default, handler: {[weak self] ( paramAction : UIAlertAction! ) in
            
            if let textFields = self!.controller?.textFields {
                let theTextFields = textFields as! [UITextField]
                let username = theTextFields[0].text
                println("The username is: \(username)")
                
            }
        })
        controller?.addAction(action1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func alertButtonPressed(sender: UIButton) {
        presentViewController(controller!, animated: true, completion: nil)
    }
   

}

