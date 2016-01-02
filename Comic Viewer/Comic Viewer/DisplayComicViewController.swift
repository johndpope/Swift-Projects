//
//  DisplayComicViewController.swift
//  Comic Viewer
//
//  Created by Mohan Dhar on 9/20/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

var comics = [Int : Comic]()


class DisplayComicViewController: UIViewController, UIScrollViewDelegate {
    
    let networkObject = Network()
    
    // Hardcode maximum number of comics because API does not provide it
    let maxNumComics = 1579;
    
    // Hardcode start comic
    var comicID = 1345;
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var comicImage: UIImageView!

    @IBOutlet var rightArrow: UIButton!
    @IBOutlet var leftArrow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Loading display comic view controller");

        // Load the first comic
        getComic(comicID);
        
        // After loading the first comic, load x comics to the left and x from the right
        loadLeftComics();
        loadRightComics();
        
        // Set scroll view delegate
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 3.0;
        scrollView.minimumZoomScale = 1.0;
        
        // Set activity indicator properties
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge;
        activityIndicator.color = UIColor.blackColor();

        
        self.view.bringSubviewToFront(rightArrow);
        self.view.bringSubviewToFront(leftArrow);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rightArrowPressed(sender: UIButton) {
        // If we reach the maximum number of comics, pressing the right arrow
        // should come back to comic #1
        
        print("Right arrow pressed");
        if (comicID == maxNumComics) {
            comicID = 1;
        } else {
            comicID++;
        }
        
        // Set the interface for the next comic, then load x more to the right.
        setComicInterface();
        loadRightComics();
    }

    @IBAction func leftArrowPressed(sender: UIButton) {
        // If we reach the minimum number of comics, pressing the left arrow
        // should come back to the maximum number of comics
        
        print("Left arrow pressed");
        if (comicID == 1) {
            comicID = maxNumComics;
        } else {
            comicID--;
        }
        
        // Set the interface for the next comic, then load x more to the left.
        setComicInterface();
        loadLeftComics();
    }
    
    func getComic(idNum : Int) {
        // Use the network object to receive the json data for the comic with the given idNum
        networkObject.makeGetRequest( idNum, jsonHandler: {
            (jsonObject) -> Void in
            
            
            // Unwrap the jsonObject so we are sure it is not nil
            if let jsonObject = jsonObject {
                let id = jsonObject["num"] as! Int;
                let month = jsonObject["month"] as! String;
                let year = jsonObject["year"] as! String;
                let day = jsonObject["day"] as! String;
                let title = jsonObject["title"] as! String;

                // Asynchronously get the image using the link we got from the json data
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),  {
                    // Make sure none of these are optionals
                    if let imgString = jsonObject["img"] as? String {
                        if let imgURL = NSURL(string: imgString) {
                            if let imgData = NSData(contentsOfURL: imgURL) {
                                if let img = UIImage(data: imgData) {
                                    
                                    // Create a new comic image and put it in a dictionary that maps the unique comic ID to the object itself
                                    let newComic = Comic(comicID: id, month: month, year: year, day: day, title: title, img: img);
                                    comics[id] = newComic;
                                    
                                    // If the id we just called for equals the comicID we should display,
                                    // asynchronously set the comic interface, this time on the main queue so that
                                    // the user can still interact with the interface even while the interface is loading.
                                    if (id == self.comicID) {
                                        dispatch_async(dispatch_get_main_queue(),  {
                                            self.setComicInterface();
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                })
            }
        })
    }
    
    // Load x comics to the right
    func loadRightComics() {
        for (var i = 1; i <= 5; ++i) {
            getComic(comicID + i);
        }
    }
    
    // Load x comics to the left
    func loadLeftComics() {
        for (var i = 1; i <= 5; ++i) {
            getComic(comicID - i);
        }    }
    
    func setComicInterface() {
        // Comic exists, set the title and image
        if let aComic = comics[comicID] {
            scrollView.zoomScale = 1;
            
            // Activity indicator should not be animating
            activityIndicator.stopAnimating();
            comicImage.hidden = false;

            self.navigationItem.title = aComic.title;
            comicImage.image = aComic.img;
            scrollView.contentSize = CGSizeMake(min(aComic.img.size.width, comicImage.frame.size.width),
                                                max (aComic.img.size.height, comicImage.frame.size.height));


        // Comic does not exist, do something about it
        } else {
            print("Comic does not exist");
            
            // If it doesn't exist then the activity indicator should display and start animating.
            activityIndicator.startAnimating();
            comicImage.hidden = true;
            self.navigationItem.title = "";
            
        }
    }

    // Scroll View Delegate methods
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.comicImage;
    }
    
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        return
    }

    

    
    
}
