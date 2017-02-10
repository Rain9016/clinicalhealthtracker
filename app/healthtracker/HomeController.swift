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
import CoreLocation

class HomeController: UIViewController, CLLocationManagerDelegate {
    
    let pages: [PermissionPage] = {
        let firstPage = PermissionPage(heading: "Location Services", content: "Health App requires use of your location services. This app will monitor your location and record your GPS coordinates every 15 minutes in order to map out an activity space. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f46d}")
        
        let secondPage = PermissionPage(heading: "HealthKit", content: "Health App requires access to HealthKit in order to access and record your steps and distance history. This app will also continue to monitor and record your step count and distance walked. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f442}")
        
        let thirdPage = PermissionPage(heading: "Motion & Fitness", content: "Health App requires access to Health & Fitness in order to track and record your step count and distance walked during the walk test. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f3bb}")
        
        return [firstPage, secondPage, thirdPage]
    }()

    var healthKitManager: HealthKitManager?
    var locationManager: LocationManager?
    var semaphore: DispatchSemaphore?
    
    var dataToSend = DataToSend.sharedInstance
    var hk_data = [[String:String]]()
    var distance = [String]()
    var locations = [String:String]()
    
    var timer: Timer?
    var start_location_recorded = false

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 200, y: 200, width: 100, height: 40)
        button.setTitle("press", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    func handleButton(sender: UIButton!) {
        print("latitude \(locationManager?.currentLocation?.coordinate.latitude), longitude: \(locationManager?.currentLocation?.coordinate.longitude)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(button)
        
        //UserDefaults.standard.set(nil, forKey: "unique_id")
        //UserDefaults.standard.set(nil, forKey: "permissions_requested")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        //////////////////////////////////////////////////////
        //                                                  //
        //  IF USER IS NOT LOGGED IN, PRESENT LOGIN SCREEN  //
        //                                                  //
        //////////////////////////////////////////////////////
        
        guard (UserDefaults.standard.object(forKey: "unique_id") as? String) != nil else {
            let loginController = LoginController()
            present(loginController, animated: true, completion: nil)
            return
        }
        
        ///////////////////////////////////////////////////////////////////
        //                                                               //
        //  IF PERMISSIONS HAVE NOT BEEN REQUESTED, REQUEST PERMISSIONS  //
        //                                                               //
        ///////////////////////////////////////////////////////////////////
        
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
        
        ////////////////////////////////////////////////////////////
        //                                                        //
        //  INITIALISE LOCATION MANAGER, START UPDATING LOCATION  //
        //                                                        //
        ////////////////////////////////////////////////////////////
        
        locationManager = LocationManager.sharedInstance
        locationManager?.startUpdatingLocation()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        ///////////////////////////////////////////////////////////////////
        //                                                               //
        //  IF HEALTHKIT HISTORY HAS NOT BEEN SENT, SEND HEALTHKIT DATA  //
        //                                                               //
        ///////////////////////////////////////////////////////////////////
        
        if (UserDefaults.standard.object(forKey: "hk_history_sent") as? Bool) != true {
            healthKitManager = HealthKitManager.sharedInstance
            
            semaphore = DispatchSemaphore(value: 0) //create semaphore
            get_hk_data() //get healthkit data in background
            semaphore?.wait() //wait for healthkit data
            get_distance_data() //get distance data in background
            semaphore?.wait() //wait for distance data
        
            let entry_count = hk_data.count
        
            //combine healthkit data (containing steps) with distance data
            for i in 0..<entry_count {
                hk_data[i]["distance"] = distance[i]
            }
            
            dataToSend.hk_data["hk_data"]?.append(contentsOf: self.hk_data)
            
            //////////////////////////////////////////////////////////////////
            //                                                              //
            //  IF PATIENT IS CONNECTED TO WIFI, SEND HEALTHKIT DATA TO DB  //
            //                                                              //
            //////////////////////////////////////////////////////////////////
            
            if (currentReachabilityStatus == .reachableViaWiFi) {
                //send_data(data: dataToSend.hk_data)
            } else {
                print("Not connected to wi-fi")
            }
        }
    }
    
    func countdown() {
        guard start_location_recorded else {
            print("\(locationManager?.currentLocation?.coordinate.latitude), \(locationManager?.currentLocation?.coordinate.longitude)")
            timer?.invalidate()
            start_location_recorded = true
            
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
            return
        }
        
        print("\(locationManager?.currentLocation?.coordinate.latitude), \(locationManager?.currentLocation?.coordinate.longitude)")
    }
}

extension HomeController {
    
    func get_hk_data() {
        let unique_id: String = UserDefaults.standard.object(forKey: "unique_id") as! String
        
        let query = HKSampleQuery(sampleType: healthKitManager!.stepCount!, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                print("error =>", error.debugDescription)
            } else {
                for entry in results as! [HKQuantitySample] {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let start_time = dateFormatter.string(from: entry.startDate)
                    let end_time = dateFormatter.string(from: entry.endDate)
                    let steps = String(Int(entry.quantity.doubleValue(for: HKUnit.count())))
                    
                    self.hk_data.append(["unique_id":unique_id, "start_time":start_time, "end_time":end_time, "steps":steps])
                }
                self.semaphore?.signal()
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
    }
    
    func get_distance_data() {
        let query = HKSampleQuery(sampleType: healthKitManager!.distanceWalkingRunning!, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                print("error =>", error.debugDescription)
            } else {
                for entry in results as! [HKQuantitySample] {
                    let distance = String(Int(entry.quantity.doubleValue(for: HKUnit.meter())))
                    
                    self.distance.append(distance)
                }
                self.semaphore?.signal()
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
    }
    
    func send_data(data: [String:[[String:String]]]) {
        let data_type = Array(data.keys).first
        var url_string: String?
        
        if (data_type == "hk_data") {
            if (data["hk_data"]?.count)! > 0 {
                url_string = "https://www.clinicalhealthtracker.com/web-service/insert-hk-data.php"
            } else {
                print("no data to send")
                return
            }
        } else if (data_type == "location_data") {
            print("location_data")
        } else if (data_type == "questionnaire_data") {
            print("questionnaire_data")
        } else if (data_type == "walk_test_data") {
            print("walk_test_data")
        }
        
        do {
            let json_data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            
            let request: URLRequest = {
                let url = URL(string: url_string!)
                var request = URLRequest(url: url!)
                
                request.httpMethod = "POST"
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = json_data
                return request
            }()
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    print("error =>", error.debugDescription)
                    return
                }
                
                do {
                    let data = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    let err = data["error"] as! Bool
                    
                    if err {
                        print(data["message"]!)
                        return
                    } else {
                        print(data["message"]!)
                    }
                } catch {
                    print("error =>", error.localizedDescription) //e.g. The data couldn’t be read because it isn’t in the correct format
                    return
                }
            })
            
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
    }
}
