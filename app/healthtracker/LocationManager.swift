//
//  LocationManager.swift
//  healthtracker
//
//  Created by untitled on 6/2/17.
//
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        guard CLLocationManager.authorizationStatus() == .authorizedAlways else {
            locationManager.requestAlwaysAuthorization()
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.delegate = self
            
            return
        }
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        self.currentLocation = location
        
        print("latitude \(location.coordinate.latitude), longitude: \(location.coordinate.longitude)")
    }
    
    func isAuthorized() -> Bool {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            return true
        }
        
        return false
    }
    
    func decreaseAccuracy() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    func increaseAccuracy() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
