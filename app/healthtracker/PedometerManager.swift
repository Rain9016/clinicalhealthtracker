//
//  ActivityManager.swift
//  LocationManagerSingleton
//
//  Created by untitled on 6/2/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import Foundation
import CoreMotion

class PedometerManager: NSObject {
    
    static let sharedInstance: PedometerManager = {
        let instance = PedometerManager()
        return instance
    }()
    
    var pedometer: CMPedometer?
    
    override init() {
        super.init()
        
        if CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable() {
            self.pedometer = CMPedometer()
            
            guard let pedometer = self.pedometer else {
                return
            }
            
            pedometer.queryPedometerData(from: Date(), to: Date(), withHandler: { (data, error) in
                if (error != nil) {
                    print(error.debugDescription) //105 means you are not authorized
                }
            })
        } else {
            print("Pedometer unavailable")
        }
    }
    
    func startUpdates() {
        
    }
    
    func isStepCountingAvailable() -> Bool {
        if (CMPedometer.isStepCountingAvailable()) {
            return true
        }
        
        return false
    }
    
    func isDistanceAvailable() -> Bool {
        if (CMPedometer.isDistanceAvailable()) {
            return true
        }
        
        return false
    }
}
