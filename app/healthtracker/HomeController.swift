//
//  HomeController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit
import HealthKit

class HomeController: UIViewController {
    let healthKitManager = HealthKitManager.sharedInstance
    var steps = [HKQuantitySample]()
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        getSteps()
        printSteps()
        
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 200)
        label.text = "hello"
        
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 300, width: 100, height: 50)
        button.backgroundColor = UIColor.blue
        button.setTitle("Begin", for: .normal)
        
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }
    
    func handleButton() {
        if (currentReachabilityStatus == .notReachable) {
            label.text = "not reachable"
        } else if (currentReachabilityStatus == .reachableViaWWAN) {
            label.text = "reachable via WWAN"
        } else if (currentReachabilityStatus == .reachableViaWiFi) {
            label.text = "reachable via wifi"
        }
    }
}

extension HomeController {
    func getSteps() {
        let dataToRead = NSSet(object: healthKitManager.stepsCount!)
        
        healthKitManager.healthStore?.requestAuthorization(toShare: nil, read: dataToRead as? Set<HKObjectType>, completion: { (success, error) in
            if success {
                //self.printSteps()
            } else {
                print(error.debugDescription)
            }
        })
    }
    
    func printSteps() {
        let query = HKSampleQuery(sampleType: healthKitManager.stepsCount!, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                print("error")
            } else {
                for steps in results as! [HKQuantitySample] {
                    let stepsCount = HKUnit.count()
                    let date = self.dateTimeToString(date: steps.startDate as NSDate, component: "date")
                    let startTime = self.dateTimeToString(date: steps.startDate as NSDate, component: "time")
                    let endTime = self.dateTimeToString(date: steps.endDate as NSDate, component: "time")
                    print("steps: \(steps.quantity.doubleValue(for: stepsCount)), date: \(date), start: \(startTime), end: \(endTime)")
                }
            }
        }
        
        healthKitManager.healthStore?.execute(query)
    }
    
    func dateTimeToString(date: NSDate, component: String) -> String {
        let calendar = NSCalendar.current
        var result = ""
        
        if (component == "date") {
            let day = calendar.component(.day, from: date as Date)
            let month = calendar.component(.month, from: date as Date)
            let year = calendar.component(.year, from: date as Date)
            
            result = "\(day):\(month):\(year)"
        } else if (component == "time") {
            let hour = calendar.component(.hour, from: date as Date)
            let minutes = calendar.component(.minute, from: date as Date)
            let seconds = calendar.component(.second, from: date as Date)
            
            result = "\(hour):\(minutes):\(seconds)"
        }
        
        return result
    }
}
