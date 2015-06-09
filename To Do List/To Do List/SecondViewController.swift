//
//  SecondViewController.swift
//  To Do List
//
//  Created by Mohan Dhar on 12/23/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
      
    @IBOutlet var taskNameOutlet: UITextField!
    
    @IBAction func createTask(sender: UIBarButtonItem) {
        todoItems.append(taskNameOutlet.text);
        let data = todoItems
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "todoItems");
        NSUserDefaults.standardUserDefaults().synchronize();
        taskNameOutlet.text = "";
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        taskNameOutlet.text = "";
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        taskNameOutlet.resignFirstResponder();
        return true;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

