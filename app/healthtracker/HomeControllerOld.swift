//
//  HomeController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit
import HealthKit

class HomeControllerOld: UIViewController {
    
    let pages: [PermissionPage] = {
        let firstPage = PermissionPage(heading: "Location Services", content: "Health App requires use of your location services. This app will monitor your location and record your GPS coordinates every 15 minutes in order to map out an activity space. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f46d}")
        
        let secondPage = PermissionPage(heading: "HealthKit", content: "Health App requires access to HealthKit in order to access and record your steps and distance history. This app will also continue to monitor and record your step count and distance walked. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f442}")
        
        let thirdPage = PermissionPage(heading: "Motion & Fitness", content: "Health App requires access to Health & Fitness in order to track and record your step count and distance walked during the walk test. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f3bb}")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    //let healthKitManager = HealthKitManager.sharedInstance
    var steps = [HKQuantitySample]()
    
    /* http://stackoverflow.com/questions/7886096/unbalanced-calls-to-begin-end-appearance-transitions-for-uitabbarcontroller-0x */
    override func viewDidAppear(_ animated: Bool) {
        guard (UserDefaults.standard.object(forKey: "unique_id") as? String) != nil else {
            let loginController = LoginController()
            present(loginController, animated: true, completion: nil)
            return
        }
        
        guard (UserDefaults.standard.object(forKey: "permissions_requested") as? Bool) == true else {
            let permissionController = PermissionController()
            permissionController.pages = self.pages
            permissionController.heading = (pages.first?.heading)!
            permissionController.content = (pages.first?.content)!
            permissionController.unicodeEscaped = (pages.first?.unicodeEscaped)!
            
            let navController = UINavigationController(rootViewController: permissionController)
            present(navController, animated: true, completion: nil)
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        UserDefaults.standard.set(nil, forKey: "unique_id")
        UserDefaults.standard.set(nil, forKey: "permissions_requested")
        
        /*
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
         */
    }
    
    let label = UILabel()
    
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

extension HomeControllerOld {
    func getSteps() {
        
    }
    
    /*
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
     */
    
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
