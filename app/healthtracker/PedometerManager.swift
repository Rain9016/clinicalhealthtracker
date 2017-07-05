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
    var steps = 0
    var distance = 0
    
    override init() {
        super.init()
        
        if CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable() {
            self.pedometer = CMPedometer()
            
            guard let pedometer = self.pedometer else {
                return
            }
            
            pedometer.queryPedometerData(from: Date(), to: Date(), withHandler: { (data, error) in
                if (error != nil) {
                    //print(error.debugDescription) //105 means you are not authorized
                    return
                }
            })
        } else {
            //print("Pedometer unavailable")
        }
    }
    
    func startUpdates() {
        guard let pedometer = self.pedometer else {
            return
        }
        
        let current_time = Date()
        
        pedometer.startUpdates(from: current_time) { (data: CMPedometerData?, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if (error != nil) {
                    print(error.debugDescription)
                    return
                }
                
                self.steps = data?.numberOfSteps as! Int
                self.distance = data?.distance as! Int
            })
        }
    }
    
    func stopUpdates() {
        guard let pedometer = self.pedometer else {
            return
        }
        
        pedometer.stopUpdates()
    }
    
    ////////////////////////////////
    //                            //
    //  RESET STEPS AND DISTANCE  //
    //                            //
    ////////////////////////////////
    func reset() {
        self.steps = 0
        self.distance = 0
    }
    
    ///////////////////////////////////////////
    //                                       //
    //  CHECK IF STEP COUNTING IS AVAILABLE  //
    //                                       //
    ///////////////////////////////////////////
    func isStepCountingAvailable() -> Bool {
        if (CMPedometer.isStepCountingAvailable()) {
            return true
        }
        
        return false
    }
    
    ///////////////////////////////////////////////
    //                                           //
    //  CHECK IF WALK/RUN DISTANCE IS AVAILABLE  //
    //                                           //
    ///////////////////////////////////////////////
    func isDistanceAvailable() -> Bool {
        if (CMPedometer.isDistanceAvailable()) {
            return true
        }
        
        return false
    }
}
