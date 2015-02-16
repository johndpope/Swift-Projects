//
//  ViewController.swift
//  Learning Maps
//
//  Created by Mohan Dhar on 12/28/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var map: MKMapView!

    var manager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Core Location
        
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.requestWhenInUseAuthorization();
        manager.startUpdatingLocation();
        
        
        
        
        
        // 40.748627, -73.985707
        /*
        var latitude:CLLocationDegrees = 40.748627;
        var longitude:CLLocationDegrees = -73.985707;
        
        var latDelta:CLLocationDegrees = 0.01;
        var lonDelta:CLLocationDegrees = 0.01;
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta);
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span);
        
        map.setRegion(region, animated: true);
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location;
        annotation.title = "Statue of Liberty";
        annotation.subtitle = "One day I'll go here";
        
        map.addAnnotation(annotation);
        */
        var longPress = UILongPressGestureRecognizer(target: self, action: "action:");
        
        longPress.minimumPressDuration = 1.5;
        
        map.addGestureRecognizer(longPress);
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.map);
        
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map);

        var annotation = MKPointAnnotation();
        annotation.coordinate = newCoordinate;
        annotation.title = "New Point";
        annotation.subtitle = "One day I'll go here";
        map.addAnnotation(annotation);
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation;
        println(userLocation);
        var userLat:CLLocationDegrees = userLocation.coordinate.latitude;
        var userLon:CLLocationDegrees = userLocation.coordinate.longitude;
        
        
        var latDelta:CLLocationDegrees = 0.01;
        var lonDelta:CLLocationDegrees = 0.01;
        
        var span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta);
        var myLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: userLat, longitude: userLon);
        var region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        
        map.setRegion(region, animated: true);
        
        // Adding annotation to my location
        var annotation = MKPointAnnotation();
        annotation.coordinate = myLocation;
        annotation.title = "This is my place"
        annotation.subtitle = "I guess this is working";
        map.addAnnotation(annotation);
        
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

