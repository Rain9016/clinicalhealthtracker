//
//  HealthKitManager.swift
//  sendLocation
//
//  Created by untitled on 24/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager: NSObject {
    
    static let sharedInstance: HealthKitManager = {
        let instance = HealthKitManager()
        return instance
    }()
    
    var healthStore: HKHealthStore?
    let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
    var typesToRead = Set<HKObjectType>()
    
    override init() {
        super.init()
        
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
            
            guard let healthStore = self.healthStore else {
                return
            }
            
            typesToRead = [stepCount!, distanceWalkingRunning!]
            
            //if healthStore.authorizationStatus() == .notDetermined
            
            healthStore.requestAuthorization(toShare: nil, read: typesToRead, completion: { (success, error) in
                if success {
                    //self.printSteps()
                } else {
                    print(error.debugDescription)
                }
            })
        } else {
            print("HealthKit unavailable")
        }
    }
    
    func isAvailable() -> Bool {
        if HKHealthStore.isHealthDataAvailable() {
            return true
        }
        
        return false
    }
}
