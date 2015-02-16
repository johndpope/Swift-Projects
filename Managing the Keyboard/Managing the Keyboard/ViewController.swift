//
//  ViewController.swift
//  Managing the Keyboard
//
//  Created by Mohan Dhar on 12/23/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textFieldOutlet: UITextField!
    @IBOutlet var labelOutlet: UILabel!
    @IBAction func updateLabel(sender: UIButton) {
        labelOutlet.text = textFieldOutlet.text;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldOutlet.resignFirstResponder();
        return true;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

