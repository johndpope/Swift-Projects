//
//  FirstViewController.swift
//  To Do List
//
//  Created by Mohan Dhar on 12/23/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

var todoItems:[String] = [];

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell");
        cell.textLabel?.text = todoItems[indexPath.row];
        return cell;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        NSUserDefaults.standardUserDefaults().removeObjectForKey("todoItems");
        NSUserDefaults.standardUserDefaults().synchronize();
        */
    }
    
    

    override func viewWillAppear(animated: Bool) {
      
        if var data:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("todoItems") {
            
            todoItems = [];
            for (var i = 0; i < data.count; ++i) {
                todoItems.append(data[i] as! String);
            }
        }
        tableViewOutlet.reloadData();
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            todoItems.removeAtIndex(indexPath.row);
        }
        let data = todoItems;
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "todoItems");
        NSUserDefaults.standardUserDefaults().synchronize();
        tableViewOutlet.reloadData();
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

