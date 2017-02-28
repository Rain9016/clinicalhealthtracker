//
//  HomeController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//
//  Useful links: http://stackoverflow.com/questions/7886096/unbalanced-calls-to-begin-end-appearance-transitions-for-uitabbarcontroller-0x, http://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3

import UIKit
import HealthKit
import CoreLocation
import LocalAuthentication /* Needed to check whether device passcode has been set */

class HomeController: UIViewController, CLLocationManagerDelegate {
    
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
    
    var is_recording = false
    var timer: Timer?
    var update_interval: TimeInterval = 60 * 15 //every 15 minutes
    
    /////////////////////////
    //                     //
    //  HOME PAGE CONTENT  //
    //                     //
    /////////////////////////
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let welcome_label: UILabel = {
        let label = UILabel()
        label.text = "Welcome to"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let imageView: UIImageView = {
        let imageName = "app-icon"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        return imageView
    }()
    
    let logo_label: UILabel = {
        let label = UILabel()
        label.text = "healthapp"
        label.font = UIFont(name: "Lobster 1.4", size: 40)
        label.textAlignment = .center
        return label
    }()
    
    let content_label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "Thank you for taking part in the study. You will be able to answer questionnaires and complete a 6 minute walk test from within this app. This data will be recorded by the app, along with your step data and location data, and will be uploaded to a secure database when you are connected to Wi-Fi. Please do not close this app - leave it running in the background. If you restart your phone please relaunch the app as soon as possible."
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Home"
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true /* attach the top of the scrollview to below the navigation bar */
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true /* attach the bottom of the scrollview to above the tab bar */
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(welcome_label)
        
        welcome_label.translatesAutoresizingMaskIntoConstraints = false
        welcome_label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        welcome_label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        welcome_label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        
        contentView.addSubview(container)
        contentView.sendSubview(toBack: container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        container.topAnchor.constraint(equalTo: welcome_label.bottomAnchor, constant: -10).isActive = true
        
        container.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        container.addSubview(logo_label)
        
        let labelSize: CGSize = logo_label.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        logo_label.translatesAutoresizingMaskIntoConstraints = false
        logo_label.widthAnchor.constraint(equalToConstant: labelSize.width + 6).isActive = true
        logo_label.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        logo_label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: -3).isActive = true
        logo_label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        container.heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.widthAnchor.constraint(equalToConstant: 60 + labelSize.width + 3).isActive = true
        
        contentView.addSubview(content_label)
        
        content_label.translatesAutoresizingMaskIntoConstraints = false
        content_label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        content_label.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20).isActive = true
        content_label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
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
        
        ///////////////////////////////////////////////////////////////////
        //                                                               //
        //  IF HEALTHKIT HISTORY HAS NOT BEEN SENT, SEND HEALTHKIT DATA  //
        //                                                               //
        ///////////////////////////////////////////////////////////////////
        
        healthKitManager = HealthKitManager.sharedInstance
        
        if (UserDefaults.standard.object(forKey: "hk_history_sent") as? Bool) != true {
            get_hk_data() //get healthkit data in background
            send_data(type: "healthkit")
            
            UserDefaults.standard.set(true, forKey: "hk_history_sent")
        }
        
        /////////////////////////////////////////////////////////////////////////////////////////////////
        //                                                                                             //
        //  INITIALISE LOCATION MANAGER, SET UNIQUE ID, RECORD INITIAL LOCATION, START 15 MIN UPDATES  //
        //                                                                                             //
        /////////////////////////////////////////////////////////////////////////////////////////////////
        
        locationManager = LocationManager.sharedInstance
        
        if !(is_recording) {
            unique_id = UserDefaults.standard.object(forKey: "unique_id") as? String
            
            locationManager?.startUpdatingLocation()
        
            updateLocation()
            self.timer = Timer.scheduledTimer(timeInterval: self.update_interval, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
            
            is_recording = true
        }
    }
    
    func countdown() {
        if !devicePasscodeSet() {
            get_hk_data(start_date: last_hk_update)
            send_data(type: "healthkit")
        }
        
        send_data(type: "survey")
        send_data(type: "walk_test")
        
        /* get_location_data() and send_data(type: "location") within */
        updateLocation()
    }
    
    func updateLocation() {
        /* delete old location, search for new one */
        if (locationManager?.currentLocation != nil) {
            locationManager?.currentLocation = nil
        }
        
        if (locationManager?.getAccuracy() != kCLLocationAccuracyBestForNavigation) {
            locationManager?.increaseAccuracy()
        }
        
        /* get and send location 30 seconds after location accuracy has increased to give it time to locate patient */
        let when = DispatchTime.now() + .seconds(30) //the .seconds is an "implicit member expression"
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.get_location_data()
            self.send_data(type: "location")
            self.locationManager?.decreaseAccuracy()
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                       //
    //  THIS WILL CHECK IF A DEVICE PASSCODE HAS BEEN SET.                                   //
    //  IF IT HAS, DO NOT GET HEALTHKIT DATA AS THE APP WILL CRASH WHEN THE PHONE IS LOCKED  //
    //                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////
    private func devicePasscodeSet() -> Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
}

extension HomeController {
    //////////////////////////
    //                      //
    //  GET HEALTHKIT DATA  //
    //                      //
    //////////////////////////
    
    func get_hk_data(start_date: Date? = nil) {
        guard (healthKitManager?.isAvailable())! else {
            return
        }
        
        if let date = start_date {
            get_step_data(start_date: date) //get healthkit data in background
            self.semaphore.wait() //wait for healthkit data
            get_distance_data(start_date: date) //get distance data in background
            self.semaphore.wait() //wait for distance data
        } else {
            get_step_data() //get healthkit data in background
            self.semaphore.wait() //wait for healthkit data
            get_distance_data() //get distance data in background
            self.semaphore.wait() //wait for distance data
        }
        
        if (hk_data.count > 0) {
            //combine healthkit data (containing steps) with distance data
            for i in 0..<hk_data.count {
                hk_data[i]["distance"] = distance[i]
            }
            
            //add it to dataToSend object
            dataToSend.hk_data["hk_data"]?.append(contentsOf: self.hk_data)
        
            hk_data.removeAll()
            distance.removeAll()
        }
        
        /*
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(dateFormatter.string(from: self.last_hk_update))
 */
    }
    
    func get_step_data(start_date: Date? = nil) {
        guard (healthKitManager?.isAvailable())! else {
            return
        }
        
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
                
                if let end_date = results?.last?.endDate {
                    self.last_hk_update = end_date + 1
                }
                
                self.semaphore.signal()
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
    }
    
    func get_distance_data(start_date: Date? = nil) {
        guard (healthKitManager?.isAvailable())! else {
            return
        }
        
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
}

extension UIViewController {
    /////////////////
    //             //
    //  SEND DATA  //
    //             //
    /////////////////
    
    func send_data(type: String) {
        ////////////////////////////////////////
        //                                    //
        //  IF NOT CONNECTED TO WIFI, RETURN  //
        //                                    //
        ////////////////////////////////////////
        guard currentReachabilityStatus == .reachableViaWiFi else {
            print("Not connected to wi-fi")
            return
        }
        
        ///////////////////////////////////////
        //                                   //
        //  IF CONNECTED TO WIFI, SEND DATA  //
        //                                   //
        ///////////////////////////////////////
        let stored_data = DataToSend.sharedInstance
        var url_string: String?
        var data_to_send = [String:[[String:String]]]()
        
        switch type {
        case "healthkit":
            if (stored_data.hk_data["hk_data"]?.count)! > 0 {
                data_to_send = stored_data.hk_data
                //url_string = "https://www.clinicalhealthtracker.com/web-service/insert-hk-data.php"
                url_string = "http://cht.dev/web-service/insert-hk-data.php"
            } else {
                print("no hk data to send")
                return
            }
        case "location":
            if (stored_data.location_data["location_data"]?.count)! > 0 {
                data_to_send = stored_data.location_data
                //url_string = "https://www.clinicalhealthtracker.com/web-service/insert-location-data.php"
                url_string = "http://cht.dev/web-service/insert-location-data.php"
            } else {
                print("no location data to send")
                return
            }
        case "survey":
            if (stored_data.survey_data["survey_data"]?.count)! > 0 {
                data_to_send = stored_data.survey_data
                //url_string = "https://www.clinicalhealthtracker.com/web-service/insert-survey-data.php"
                url_string = "http://cht.dev/web-service/insert-survey-data.php"
            } else {
                print("no survey data to send")
                return
            }
        case "walk_test":
            if (stored_data.walk_test_data["walk_test_data"]?.count)! > 0 {
                data_to_send = stored_data.walk_test_data
                //url_string = "https://www.clinicalhealthtracker.com/web-service/insert-walk-test-data.php"
                url_string = "http://cht.dev/web-service/insert-walk-test-data.php"
            } else {
                print("no walk test data to send")
                return
            }
        default:
            return
        }
        
        //////////////////////////////////////////////////////////////
        //                                                          //
        //  CONVERT DICTIONARY TO JSON, SEND JSON VIA POST REQUEST  //
        //                                                          //
        //////////////////////////////////////////////////////////////
        do {
            let json_data = try JSONSerialization.data(withJSONObject: data_to_send, options: .prettyPrinted)
            
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
                        
                        switch type {
                        case "healthkit":
                            stored_data.hk_data["hk_data"]?.removeAll()
                        case "location":
                            stored_data.location_data["location_data"]?.removeAll()
                        case "survey":
                            stored_data.survey_data["survey_data"]?.removeAll()
                        case "walk_test":
                            stored_data.walk_test_data["walk_test_data"]?.removeAll()
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
