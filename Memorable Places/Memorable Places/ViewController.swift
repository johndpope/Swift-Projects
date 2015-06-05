//
//  ViewController.swift
//  Memorable Places
//
//  Created by Mohan Dhar on 5/21/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (activePlace == -1) {
            
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            
            let latitude = NSString(string:places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string:places[activePlace]["long"]!).doubleValue
            
            var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            var latDelta:CLLocationDegrees = 0.01
            var lonDelta:CLLocationDegrees = 0.01
            
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            
            self.map.setRegion(region, animated: true)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = places[activePlace]["name"]
            annotation.subtitle = "optional"
            self.map.addAnnotation(annotation)
            
            
        }
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 2.0
        map.addGestureRecognizer(uilpgr);
        
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.map)
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            // CLGGeocoder to get coordinates of our location
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
                var address = ""
                
                if (error == nil) {
                    if let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark) {
                        
                        var subThoroughfare:String = ""
                        var thoroughfare:String = ""
                        
                        if p.subThoroughfare != nil {
                            subThoroughfare = p.subThoroughfare
                        }
                        
                        if p.thoroughfare != nil {
                            thoroughfare = p.thoroughfare
                        }
                        
                        address = "\(subThoroughfare) \(thoroughfare)"
                        
                        
                    }
                
                }
                
                if (address == "") {
                    address = "Added \(NSDate())"
                }
                
            places.append(["name":address, "lat":"\(newCoordinate.latitude)","long":"\(newCoordinate.longitude)"])
                
            let data = places
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "places")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = address
            annotation.subtitle = "optional"
            self.map.addAnnotation(annotation)
                
            })
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

