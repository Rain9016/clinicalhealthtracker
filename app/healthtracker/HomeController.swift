//
//  HomeController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//
//  Useful links: http://stackoverflow.com/questions/7886096/unbalanced-calls-to-begin-end-appearance-transitions-for-uitabbarcontroller-0x

import UIKit
import HealthKit

class HomeController: UIViewController {
    
    let pages: [PermissionPage] = {
        let firstPage = PermissionPage(heading: "Location Services", content: "Health App requires use of your location services. This app will monitor your location and record your GPS coordinates every 15 minutes in order to map out an activity space. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f46d}")
        
        let secondPage = PermissionPage(heading: "HealthKit", content: "Health App requires access to HealthKit in order to access and record your steps and distance history. This app will also continue to monitor and record your step count and distance walked. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f442}")
        
        let thirdPage = PermissionPage(heading: "Motion & Fitness", content: "Health App requires access to Health & Fitness in order to track and record your step count and distance walked during the walk test. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f3bb}")
        
        return [firstPage, secondPage, thirdPage]
    }()

    var healthKitManager: HealthKitManager?
    var locationManager: LocationManager?
    
    var hk_data = [String:String]()
    var hk_data_to_send = [String:[[String:String]]]()
    var locations = [String:String]()
    var locations_to_send = [String:[[String:String]]]()
    
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
        
        healthKitManager = HealthKitManager.sharedInstance
    }
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        UserDefaults.standard.set(nil, forKey: "unique_id")
        UserDefaults.standard.set(nil, forKey: "permissions_requested")
    }
}

extension HomeController {
    func record_hk_data() {
        var query = HKSampleQuery(sampleType: healthKitManager!.stepCount!, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                print("error")
            } else {
                for steps in results as! [HKQuantitySample] {
                    let stepsCount = HKUnit.count()
                    print("steps:", steps.quantity.doubleValue(for: stepsCount))
                }
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
        
        query = HKSampleQuery(sampleType: healthKitManager!.stepCount!, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                print("error")
            } else {
                for steps in results as! [HKQuantitySample] {
                    let stepsCount = HKUnit.count()
                    print("steps:", steps.quantity.doubleValue(for: stepsCount))
                }
            }
        }

        healthKitManager!.healthStore?.execute(query)
    }
}
