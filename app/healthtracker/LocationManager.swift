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
    var currentHeading: CLLocationDirection?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            self.locationManager?.requestAlwaysAuthorization()
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.currentLocation = location
    }
    
    func startUpdatingHeading() {
        self.locationManager?.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        self.locationManager?.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.currentHeading = newHeading.magneticHeading
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
