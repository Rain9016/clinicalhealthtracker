//
//  HealthKitManager.swift
//  sendLocation
//
//  Created by untitled on 24/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import HealthKit

class HealthKitManager {
    
    static let sharedInstance = HealthKitManager()
    
    private init() {}
    
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    let stepsCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    let stepsUnit = HKUnit.count()
}
