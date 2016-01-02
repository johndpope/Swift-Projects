//
//  ViewComicsTableViewController.swift
//  Comic Viewer2
//
//  Created by Mohan Dhar on 9/25/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

var comics = [Int : Comic]()

class ViewComicsTableViewController: UITableViewController {
    
    // Create a network object
    let network = Network();
    
    // Number of rows in the initial tableview
    var numRows = 10;
    
    // How many comics we want to load at a time.
    let loadNumComics = 10;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Load the comics from the 1st one ever issued
        loadComics(1, completionHandler : {
            () -> Void in
            self.tableView.reloadData();
            
        });
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows;
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("comicCell", forIndexPath: indexPath) as! ComicTableViewCell;

        // If image isn't loaded, show the activity indicator
        cell.activityIndicator.startAnimating();
        
        // Configure the cell...
        
        // Load a comic and set the title
        var aComic = comics[indexPath.row + 1];
        cell.comicTitle.text = aComic?.title;
        
        // Check if the comic has an image in its properties
        // if it doesn't then asynchronously grab it from its image url
        if let cachedImage = aComic?.img {
            cell.comicImage.image = cachedImage;
            print(indexPath.row);
        } else {
            // Asynchronously get the image using the link we got from the json data
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),  {
                // Make sure none of these are optionals
                if let imgString = aComic?.imgURL {
                    if let imgURL = NSURL(string: imgString) {
                        if let imgData = NSData(contentsOfURL: imgURL) {
                            if let img = UIImage(data: imgData) {
                                
                                // Asynchronously set the image on a different queue to allow user interactivity and
                                // faster completion
                                dispatch_async(dispatch_get_main_queue(), {
                                    cell.comicImage.image = img;
                                    cell.activityIndicator.stopAnimating();
                                    aComic?.img = img;
                                })
                            }
                        }
                    }
                }
                
            })
        }

        
        
        // If we reach the end of the tableview, load more comics
        if (indexPath.row + 1 == numRows) {
            loadComics(numRows, completionHandler : { () -> Void in });
            numRows += loadNumComics;
            tableView.reloadData();
        }

        return cell;
    }

    func loadComics(idNum : Int, completionHandler : () -> Void) {
        
        // Load x number of comics
        for (var i = idNum; i < idNum + loadNumComics; ++i) {
            getComic(i);
        }
        completionHandler();
    }
    
    func getComic(idNum : Int) {
        // Use the network object to receive the json data for the comic with the given idNum
        network.makeGetRequest( idNum, jsonHandler: {
            (jsonObject) -> Void in
            
            
            // Unwrap the jsonObject so we are sure it is not nil
            if let jsonObject = jsonObject {
                let id = jsonObject["num"] as! Int;
                let month = jsonObject["month"] as! String;
                let year = jsonObject["year"] as! String;
                let day = jsonObject["day"] as! String;
                let title = jsonObject["title"] as! String;
                let imgURL = jsonObject["img"] as! String;
                
                // Create a comic using the data we received from json object
                let newComic = Comic(comicID: id, month: month, year: year, day: day, title: title, imgURL: imgURL);
                comics[id] = newComic;

            }
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destinationViewController is ViewImageViewController {
            let destination = segue.destinationViewController as! ViewImageViewController;
            if let selectedCell = sender as? ComicTableViewCell {
                // Pass the indexPath, comic ID, and image to the view controller
                // we use to see the comics better
                let indexPath = tableView.indexPathForCell(selectedCell);
                destination.comicID = indexPath!.row + 1;
                
                destination.image = selectedCell.comicImage.image;
            }
        }
    }
    

}
