//
//  ViewController.swift
//  LocationApplication
//
//  Created by Nuh Burak Karakaya on 23.07.2017.
//  Copyright © 2017 bk. All rights reserved.
//


/*
 
 Developed By Nuh Burak Karakaya.
 Project was Licanced with GPL.
 Available for Personal Usage.
 Permission must be obtained for Commercial Usage.
 for contact please send an email to burakkarakaya10@gmail.com

 */

import GoogleMaps
import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {


    let locationManager = CLLocationManager()
    var location:CLLocationCoordinate2D!
    var mapView:GMSMapView?
    
    @IBOutlet weak var map: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.frame.size.width = UIScreen.main.bounds.size.width
        map.center.x = view.center.x
        map.frame.size.height = UIScreen.main.bounds.size.height/2

        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        var lat = 0,lon = 0
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
            
            if(locationManager.location == nil)
            {
                return;
            }
            
            lat = Int(locationManager.location!.coordinate.latitude)
            lon = Int(locationManager.location!.coordinate.longitude)
           
        }
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon), zoom: 6.0)
         mapView = GMSMapView.map(withFrame: CGRect(x: map.center.x, y: map.center.y, width: map.frame.size.width, height: map.frame.size.height), camera: GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon), zoom: 5.5))
        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.center = map.center
        
        map.addSubview(mapView!)
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker.title = "Now, You are Here!"
        marker.map = mapView
        
    }


    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if manager.location != nil
        {
            var lat = manager.location?.coordinate.latitude
            var lon = manager.location?.coordinate.longitude

            let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lon!), zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lon!))
            marker.title = "Now, You are Here!"
            marker.map = mapView
    
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        
        print(error)
    }
    
   
    

}

