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
    
    private override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
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

        let currentLocation = location
        
        print("latitude \(currentLocation.coordinate.latitude), longitude: \(currentLocation.coordinate.longitude)")
    }
    
    func isAlwaysAllowed() -> Bool {
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
