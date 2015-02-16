//
//  ViewController.swift
//  Where Am I
//
//  Created by Mohan Dhar on 12/28/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var reloadButton: UIButton!

    var manager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Location Manager
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.requestWhenInUseAuthorization();
        manager.startUpdatingLocation();
        
        // Error and Reload messages
        errorLabel.hidden = true;
        reloadButton.hidden = true;

    }
    
    @IBAction func reload(sender: UIButton) {
        viewDidLoad();
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error);
        errorLabel.hidden = false;
        reloadButton.hidden = false;
        UIView.animateWithDuration(1.5, animations: {
            self.errorLabel.center = CGPointMake(self.errorLabel.center.x + 400, self.errorLabel.center.y);
            self.reloadButton.center = CGPointMake(self.reloadButton.center.x - 400, self.reloadButton.center.y);
        })
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[0] as CLLocation;
        println(location);

        latitudeLabel.text = "\(location.coordinate.latitude)";
        longitudeLabel.text = "\(location.coordinate.longitude)";
        speedLabel.text = "\(location.speed)";
        headingLabel.text = "\(location.course)";
        altitudeLabel.text = "\(location.altitude)";
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:{(placemarks, error) in
            if (error != nil) {
                println("Error: \(error)"); }
            else {
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark);
                
                self.addressLabel.text = "\(p.subThoroughfare) \(p.thoroughfare)\n\(p.locality) \(p.administrativeArea) \(p.postalCode)";
                
            }
        })
    }

    override func viewDidLayoutSubviews() {
        errorLabel.center = CGPointMake(errorLabel.center.x - 400, errorLabel.center.y);
        reloadButton.center = CGPointMake(reloadButton.center.x + 400, reloadButton.center.y);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

