//
//  ViewImageViewController.swift
//  Comic Viewer2
//
//  Created by Mohan Dhar on 9/26/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    var comicID : Int!
    var image : UIImage!
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


        // Set up the scroll view delegate, min zoom, and max zoom
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 3.0;
        
        
        // Set title and image of the comic we are trying to view
        self.navigationItem.title = comics[comicID]?.title
        if let cachedImage = comics[comicID]?.img {
            self.image = cachedImage;
        }
        
        // Create an imageview and set its frame equal to the image's size
        imageView = UIImageView(image: image);
        imageView.frame = CGRectMake(0, self.scrollView.center.y,  image.size.width, image.size.height)
        scrollView.addSubview(imageView);
        
        // Can only zoom in on picture
        scrollView.contentSize = image.size;
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UIScrollView delegates
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView;
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        return;
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
