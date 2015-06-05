//
//  TableViewController.swift
//  Memorable Places
//
//  Created by Mohan Dhar on 5/21/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>]()

var activePlace = -1

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        if var data:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("places") {
            if places.count == 1 {
                places.removeAtIndex(0)
                places.append(["name":"Taj Mahal", "lat":"27.175277","long":"78.042128"])
            }
            for (var i = 0; i < data.count; ++i) {
                places.append(["name":data[i]["name"] as String, "lat":data[i]["lat"] as String, "long":data[i]["long"] as String])
            }
            println(places)

        }
        

        if places.count == 1 {
            places.removeAtIndex(0)
            places.append(["name":"Taj Mahal", "lat":"27.175277","long":"78.042128"])
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return places.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = places[indexPath.row]["name"]
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activePlace = indexPath.row
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "add" {
            activePlace = -1
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            places.removeAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            let data = places
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "places")
            NSUserDefaults.standardUserDefaults().synchronize()

            
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
