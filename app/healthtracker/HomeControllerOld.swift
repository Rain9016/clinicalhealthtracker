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

class HomeControllerOld: UIViewController, CLLocationManagerDelegate {
    
    let pages: [PermissionPage] = {
        let firstPage = PermissionPage(heading: "Location Services", content: "Health App requires use of your location services. This app will monitor your location and record your GPS coordinates every 15 minutes in order to map out an activity space. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f46d}")
        
        let secondPage = PermissionPage(heading: "HealthKit", content: "Health App requires access to HealthKit in order to access and record your steps and distance history. This app will also continue to monitor and record your step count and distance walked. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f442}")
        
        let thirdPage = PermissionPage(heading: "Motion & Fitness", content: "Health App requires access to Health & Fitness in order to track and record your step count and distance walked during the walk test. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f3bb}")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    var healthKitManager: HealthKitManager?
    var locationManager: LocationManager?
    
    var unique_id: String?
    
    let semaphore = DispatchSemaphore(value: 0) //create semaphore
    
    var dataToSend = DataToSend.sharedInstance
    var hk_data = [[String:String]]()
    var distance = [String]()
    var last_hk_update = Date()
    
    var timer: Timer?
    var update_interval: TimeInterval = 10
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 200, y: 200, width: 100, height: 40)
        button.setTitle("press", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    func handleButton(sender: UIButton!) {
        print("\(dataToSend.hk_data["hk_data"]?.count)")
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
        
        guard (UserDefaults.standard.object(forKey: "unique_id")) != nil else {
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
        
        /////////////////////////////////////
        //                                 //
        //  SET UNIQUE_ID GLOBAL VARIABLE  //
        //                                 //
        /////////////////////////////////////
        
        unique_id = UserDefaults.standard.object(forKey: "unique_id") as? String
        
        ////////////////////////////////////////////////////////////
        //                                                        //
        //  INITIALISE LOCATION MANAGER, START UPDATING LOCATION  //
        //                                                        //
        ////////////////////////////////////////////////////////////
        
        locationManager = LocationManager.sharedInstance
        locationManager?.startUpdatingLocation()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(record_initial_location), userInfo: nil, repeats: true)
        
        ///////////////////////////////////////////////////////////////////
        //                                                               //
        //  IF HEALTHKIT HISTORY HAS NOT BEEN SENT, SEND HEALTHKIT DATA  //
        //                                                               //
        ///////////////////////////////////////////////////////////////////
        
        if (UserDefaults.standard.object(forKey: "hk_history_sent") as? Bool) != true {
            healthKitManager = HealthKitManager.sharedInstance
            //get_hk_data() //get healthkit data in background
            
            //print(dataToSend.hk_data["hk_data"]!)
            
            //////////////////////////////////////////////////////////////////
            //                                                              //
            //  IF PATIENT IS CONNECTED TO WIFI, SEND HEALTHKIT DATA TO DB  //
            //                                                              //
            //////////////////////////////////////////////////////////////////
            
            guard currentReachabilityStatus == .reachableViaWiFi else {
                print("Not connected to wi-fi")
                return
            }
            
            //send_data(data: dataToSend.hk_data)
            
            UserDefaults.standard.set(true, forKey: "hk_history_sent")
        }
    }
    
    func record_initial_location() {
        get_location_data()
        
        guard currentReachabilityStatus == .reachableViaWiFi else {
            print("Not connected to wi-fi")
            return
        }
        
        send_data(data: dataToSend.location_data)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: update_interval, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    func countdown() {
        //get_hk_data(start_date: last_hk_update)
        get_location_data()
        
        guard currentReachabilityStatus == .reachableViaWiFi else {
            print("Not connected to wi-fi")
            return
        }
        
        //send_data(data: dataToSend.hk_data)
        send_data(data: dataToSend.location_data)
        
        if (dataToSend.questionnaire_data["questionnaire_data"]?.count)! > 0 {
            
        }
        
        if (dataToSend.walk_test_data["walk_test_data"]?.count)! > 0 {
            
        }
    }
}

extension HomeControllerOld {
    //////////////////////////
    //                      //
    //  GET HEALTHKIT DATA  //
    //                      //
    //////////////////////////
    
    func get_hk_data(start_date: Date? = nil) {
        get_step_data() //get healthkit data in background
        self.semaphore.wait() //wait for healthkit data
        get_distance_data() //get distance data in background
        self.semaphore.wait() //wait for distance data
        
        let entry_count = hk_data.count
        
        if (hk_data.count > 0) {
            //combine healthkit data (containing steps) with distance data
            for i in 0..<entry_count {
                hk_data[i]["distance"] = distance[i]
            }
            
            //add it to dataToSend object
            dataToSend.hk_data["hk_data"]?.append(contentsOf: self.hk_data)
            
            hk_data.removeAll()
            last_hk_update = Date()
        }
    }
    
    func get_step_data(start_date: Date? = nil) {
        var predicate: NSPredicate?
        
        if (start_date != nil) {
            predicate = HKQuery.predicateForSamples(withStart: start_date, end: Date(), options: [])
        }
        
        let query = HKSampleQuery(sampleType: healthKitManager!.stepCount!, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
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
                    
                    self.hk_data.append(["unique_id":self.unique_id!, "start_time":start_time, "end_time":end_time, "steps":steps])
                }
                self.semaphore.signal()
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
    }
    
    func get_distance_data(start_date: Date? = nil) {
        var predicate: NSPredicate?
        
        if (start_date != nil) {
            predicate = HKQuery.predicateForSamples(withStart: start_date, end: Date(), options: [])
        }
        
        let query = HKSampleQuery(sampleType: healthKitManager!.distanceWalkingRunning!, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                print("error =>", error.debugDescription)
            } else {
                for entry in results as! [HKQuantitySample] {
                    let distance = String(Int(entry.quantity.doubleValue(for: HKUnit.meter())))
                    
                    self.distance.append(distance)
                }
                self.semaphore.signal()
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
    }
    
    /////////////////////////
    //                     //
    //  GET LOCATION DATA  //
    //                     //
    /////////////////////////
    
    func get_location_data() {
        guard let location = locationManager?.currentLocation else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let current_time = dateFormatter.string(from: Date())
        
        let latitude: String = String(location.coordinate.latitude)
        let longitude: String = String(location.coordinate.longitude)
        dataToSend.location_data["location_data"]?.append(["unique_id":self.unique_id!, "time":current_time, "latitude":latitude, "longitude":longitude])
    }
    
    /////////////////
    //             //
    //  SEND DATA  //
    //             //
    /////////////////
    
    func send_data(data: [String:[[String:String]]]) {
        let data_type = Array(data.keys).first
        var url_string: String?
        
        switch data_type! {
        case "hk_data":
            if (data["hk_data"]?.count)! > 0 {
                url_string = "https://www.clinicalhealthtracker.com/web-service/insert-hk-data.php"
            } else {
                print("no hk data to send")
                return
            }
        case "location_data":
            if (data["location_data"]?.count)! > 0 {
                //url_string = "https://www.clinicalhealthtracker.com/web-service/insert-location-data.php"
                url_string = "http://cht.dev/web-service/insert-location-data.php"
            } else {
                print("no location data to send")
                return
            }
            
        case "questionnaire_data & Fitness":
            return
        case "walk_test_data & Fitness":
            return
        default:
            return
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
                        //////////////////////////////////////////////////////
                        //                                                  //
                        //  IF SUCCESSFUL, DELETE PREVIOUS DATA FROM PHONE  //
                        //                                                  //
                        //////////////////////////////////////////////////////
                    } else {
                        print(data["message"]!)
                        
                        switch data_type! {
                        case "hk_data":
                            self.dataToSend.hk_data["hk_data"]?.removeAll()
                        case "location_data":
                            self.dataToSend.location_data["location_data"]?.removeAll()
                        case "questionnaire_data":
                            self.dataToSend.questionnaire_data["questionnaire_data"]?.removeAll()
                        case "walk_test_data":
                            self.dataToSend.walk_test_data["walk_test_data"]?.removeAll()
                        default:
                            return
                        }
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
