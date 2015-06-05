//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Mohan Dhar on 6/2/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        //newUser.setValue("Rob", forKey:"username");
        //newUser.setValue("pass", forKey: "password")
        
        //newUser.setValue("Mohan", forKey:"username");
        //newUser.setValue("mohan123", forKey: "password")
        
        //newUser.setValue("Kirsten", forKey:"username");
        //newUser.setValue("pass2", forKey: "password")
        
        context.save(nil);
        
        var request = NSFetchRequest(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        // To request something from a database
        request.predicate = NSPredicate(format: "username = %@", "Kirsten")
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if (results?.count > 0) {

        
            // To process the data loop through the results
        
            for result: AnyObject in results! {
                
                if let user = result.valueForKey("username") as? String {
                    if (user == "Kirsten") {
                        // Delete something from the database
                        //context.deleteObject(result as NSManagedObject)
                        //println(user + " has been deleted")
                        
                        //Updating a field in the database
                        result.setValue("pass6", forKey: "password")
                        println(result)
                        
                    }
                }
                
                //if let pass = result.password! {
                    
                //    println(pass);
                    
                //}
                
            
            }
        } else {
            println("No results");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

