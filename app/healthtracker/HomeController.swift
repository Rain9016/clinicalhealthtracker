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
import UserNotifications

class HomeController: UIViewController, CLLocationManagerDelegate {
    
    let pages: [PermissionPage] = {
        let firstPage = PermissionPage(heading: "Location Services", content: "Health Tracker requires use of your location services. As long as it remains open, Health Tracker will monitor your location and record your GPS coordinates every 15 minutes in order to measure your activity space. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f46d}")
        
        let secondPage = PermissionPage(heading: "Health", content: "Health Tracker requires access to Health in order to access and record your step count and distances walked history. As long as it remains installed and you open it on a weekly basis, Health Tracker will continue to monitor and record your step count and distances walked. Please press the \"Allow\" button below, and allow Health App to access Health when prompted.", unicodeEscaped: "\u{f442}")
        
        let thirdPage = PermissionPage(heading: "Notifications", content: "Health Tracker requires you to allow notifications. You will be reminded on a weekly basis to open up Health Tracker, so that it can access and record your Health data (step count and distances walked). Please press the \"Allow\" button below, and allow Health Tracker to send you notifications when prompted.", unicodeEscaped: "\u{f399}")
        
        let fourthPage = PermissionPage(heading: "Motion & Fitness", content: "Health Tracker requires access to Motion & Fitness in order to track and record your step count and distance walked during the 6 minute walk test. Please press the \"Allow\" button below, and allow Health App to access your location services when prompted.", unicodeEscaped: "\u{f3bb}")
        
        return [firstPage, secondPage, thirdPage, fourthPage]
    }()

    var healthKitManager: HealthKitManager?
    var locationManager: LocationManager?
    
    var uniqueId: String?
    
    let semaphore = DispatchSemaphore(value: 0) /* create semaphore */
    
    var userData = UserData.shared
    var healthData = [HealthData]()
    var distance = [String]()
    var lastHealthUpdate = Date()
    
    var hasLaunched = false
    var timer: Timer?
    var updateInterval: TimeInterval = 60 * 5 /* every 5 minutes */
    
    /////////////////////////
    //                     //
    //  HOME PAGE CONTENT  //
    //                     //
    /////////////////////////
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let welcomeLabel: UILabel = {
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
        let imageName = "Icon"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        return imageView
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "healthtracker"
        label.font = UIFont(name: "Lobster 1.4", size: 40)
        label.textAlignment = .center
        return label
    }()
    
    let contentLabel: UILabel = {
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
        
        contentView.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        welcomeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        
        contentView.addSubview(container)
        contentView.sendSubview(toBack: container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        container.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: -10).isActive = true
        
        container.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        container.addSubview(logoLabel)
        
        let labelSize: CGSize = logoLabel.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.widthAnchor.constraint(equalToConstant: labelSize.width + 6).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        logoLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: -3).isActive = true
        logoLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        container.heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.widthAnchor.constraint(equalToConstant: 60 + labelSize.width + 3).isActive = true
        
        contentView.addSubview(contentLabel)
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        contentLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20).isActive = true
        contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let paddingBottom = UIView()
        contentView.addSubview(paddingBottom)
        paddingBottom.translatesAutoresizingMaskIntoConstraints = false
        paddingBottom.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 25).isActive = true
        paddingBottom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    
    override func viewDidAppear(_ animated: Bool) {
        //////////////////////////////////////////////////////
        //                                                  //
        //  IF USER IS NOT LOGGED IN, PRESENT LOGIN SCREEN  //
        //                                                  //
        //////////////////////////////////////////////////////
        
        guard (UserDefaults.standard.object(forKey: "uniqueId")) != nil else {
            let loginController = LoginController()
            present(loginController, animated: true, completion: nil)
            return
        }
    
        ///////////////////////////////////////////////////////////////////
        //                                                               //
        //  IF PERMISSIONS HAVE NOT BEEN REQUESTED, REQUEST PERMISSIONS  //
        //                                                               //
        ///////////////////////////////////////////////////////////////////
        
        guard (UserDefaults.standard.object(forKey: "permissionsRequested") as? Bool) == true else {
            let permissionController = PermissionController()
            permissionController.pages = self.pages
            permissionController.heading = (pages.first?.heading)!
            permissionController.content = (pages.first?.content)!
            permissionController.unicodeEscaped = (pages.first?.unicodeEscaped)!
            
            let navController = UINavigationController(rootViewController: permissionController)
            navController.view.layoutIfNeeded()
            present(navController, animated: true, completion: nil)
            return
        }
        
        if !(hasLaunched) {
            /* set unique id */
            uniqueId = UserDefaults.standard.object(forKey: "uniqueId") as? String
        }
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //                                                                                                         //
        //  IF HEALTHKIT HISTORY HAS NOT BEEN SENT (I.E. IF lastHealthUpdate HAS NOT BEEN SET), SEND HEALTHKIT DATA  //
        //                                                                                                         //
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        healthKitManager = HealthKitManager.sharedInstance
        
        /* if HealthKit history has not yet been sent (i.e. this is the patient's first time opening the application, send HealthKit history */
        if !isKeyPresentInUserDefaults(key: "healthHistorySent") {
            getHealthData()
            sendData(type: "health")
            
            UserDefaults.standard.set(true, forKey: "healthHistorySent")
        /* otherwise, get HealthKit data from the last time the patient's HealthKit data was updated up until now */
        } else if UserDefaults.standard.object(forKey: "lastHealthUpdate") != nil && !(hasLaunched) {
            self.lastHealthUpdate = UserDefaults.standard.object(forKey: "lastHealthUpdate") as! Date
            
            getHealthData(startDate: self.lastHealthUpdate)
            sendData(type: "health")
        }
        
        /////////////////////////////////////////////////////////////////////////////////////////////////
        //                                                                                             //
        //  INITIALISE LOCATION MANAGER, SET UNIQUE ID, RECORD INITIAL LOCATION, START 15 MIN UPDATES  //
        //                                                                                             //
        /////////////////////////////////////////////////////////////////////////////////////////////////
        
        locationManager = LocationManager.sharedInstance
        
        if !(hasLaunched) {
            /* add observer to send healthkit data when app enters foreground */
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(sendHealthData), name: Notification.Name("sendHealthData"), object: nil)
            
            /* start updating location */
            locationManager?.startUpdatingLocation()
        
            /* update location */
            updateLocation()
            
            /* start timer to send stored data every 15 minutes */
            self.timer = Timer.scheduledTimer(timeInterval: self.updateInterval, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
            
            hasLaunched = true
        }
        
        ///////////////////////////////////////////////////////////////////
        //                                                               //
        //  IF NOTIFICATIONS ARE ENABLED, SCHEDULE WEEKLY NOTIFICATIONS  //
        //                                                               //
        ///////////////////////////////////////////////////////////////////
        
        let settings: UIUserNotificationSettings? = UIApplication.shared.currentUserNotificationSettings
        var notificationsEnabled = false
        
        /* check whether notifications are enabled */
        if (settings?.types != UIUserNotificationType.init(rawValue: 0)) {
            notificationsEnabled = true
        }
        
        /* if notifications are enabled, schedule notification */
        if (notificationsEnabled) {
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                var requestsCount = 0
                center.getPendingNotificationRequests(completionHandler: { (requests) in
                    requestsCount = requests.count
                })
                
                if requestsCount == 0 {
                    //cancel all local notifications and reschedule
                    center.removeAllDeliveredNotifications()
                    center.removeAllPendingNotificationRequests()
                    
                    //create notification
                    let content = UNMutableNotificationContent()
                    content.title = "Send Health Data"
                    content.body = "Please open Health Tracker to send your step count and distances walked to the database"
                    content.sound = UNNotificationSound.default()
                    content.badge = 1
                    
                    //create notification trigger
                    let date = Date().addingTimeInterval(60 * 60 * 24 * 7)
                    let triggerDate = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    
                    //schedule notification
                    let identifier = "sendHealthData"
                    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    center.add(request, withCompletionHandler: { (error) in
                        if error != nil {
                            //print("Error: An error occured while creating local notification with identifier " + identifier)
                            return
                        }
                    })
                }
            } else {
                if UIApplication.shared.scheduledLocalNotifications?.count == 0 {
                    
                    //create notification
                    let notification = UILocalNotification()
                    notification.alertTitle = "Send Health Data"
                    notification.alertBody = "Please open Health Tracker to send your step count and distances walked to the database"
                    notification.soundName = UILocalNotificationDefaultSoundName
                    notification.applicationIconBadgeNumber = 1
                
                    //create notification triger
                    notification.fireDate = Date().addingTimeInterval(60 * 60 * 24 * 7)
                    notification.repeatInterval = NSCalendar.Unit.weekOfYear
                
                    //schedule notification
                    UIApplication.shared.scheduleLocalNotification(notification)
                }
            }
        }
    }
    
    @objc func countdown() {
        sendData(type: "health")
        sendData(type: "survey")
        sendData(type: "heightWeight")
        sendData(type: "walkTest")
        
        /* getLocationData() and sendData(type: "location") within */
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
            self.getLocationData()
            self.sendData(type: "location")
            self.locationManager?.decreaseAccuracy()
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension HomeController {
    //////////////////////////
    //                      //
    //  GET HEALTHKIT DATA  //
    //                      //
    //////////////////////////
    
    func getHealthData(startDate: Date? = nil) {
        guard (healthKitManager?.isAvailable())! else {
            return
        }
        
        if let date = startDate {
            getStepData(startDate: date) //get healthkit data in background
            self.semaphore.wait() //wait for healthkit data
            getDistanceData(startDate: date) //get distance data in background
            self.semaphore.wait() //wait for distance data
        } else {
            getStepData() //get healthkit data in background
            self.semaphore.wait() //wait for healthkit data
            getDistanceData() //get distance data in background
            self.semaphore.wait() //wait for distance data
        }
        
        if (healthData.count > 0) {
            //combine healthkit data (containing steps) with distance data
            for i in 0..<healthData.count {
                healthData[i].distance = distance[i]
            }
            
            //add it to dataToSend object
            userData.healthData.append(contentsOf: healthData)
        
            healthData.removeAll()
            distance.removeAll()
        }
    }
    
    func getStepData(startDate: Date? = nil) {
        guard (healthKitManager?.isAvailable())! else {
            return
        }
        
        var predicate: NSPredicate?
        
        if (startDate != nil) {
            predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        }
        
        let query = HKSampleQuery(sampleType: healthKitManager!.stepCount!, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                //print(error?.localizedDescription)
                return
            } else {
                for entry in results as! [HKQuantitySample] {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let startTime = dateFormatter.string(from: entry.startDate)
                    let endTime = dateFormatter.string(from: entry.endDate)
                    let steps = String(Int(entry.quantity.doubleValue(for: HKUnit.count())))
                    
                    guard let uniqueId = self.uniqueId else { return }
                    let currentEntry = HealthData(uniqueId: uniqueId, startTime: startTime, endTime: endTime, steps: steps, distance: nil)
                    self.healthData.append(currentEntry)
                }
                
                if let endDate = results?.last?.endDate {
                    self.lastHealthUpdate = endDate + 1
                    UserDefaults.standard.set(self.lastHealthUpdate, forKey: "lastHealthUpdate")
                }
                
                self.semaphore.signal()
            }
        }
        
        healthKitManager!.healthStore?.execute(query)
    }
    
    func getDistanceData(startDate: Date? = nil) {
        guard (healthKitManager?.isAvailable())! else {
            return
        }
        
        var predicate: NSPredicate?
        
        if (startDate != nil) {
            predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        }
        
        let query = HKSampleQuery(sampleType: healthKitManager!.distanceWalkingRunning!, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
        { (query, results, error) in
            if error != nil {
                //print("error =>", error.debugDescription)
                return
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
    
    @objc func sendHealthData() {
        getHealthData(startDate: self.lastHealthUpdate)
        sendData(type: "healthkit")
    }
    
    /////////////////////////
    //                     //
    //  GET LOCATION DATA  //
    //                     //
    /////////////////////////
    
    func getLocationData() {
        guard let location = locationManager?.currentLocation else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        
        let latitude: String = String(location.coordinate.latitude)
        let longitude: String = String(location.coordinate.longitude)
        
        guard let uniqueId = self.uniqueId else { return }
        let entry = LocationData(uniqueId: uniqueId, time: currentTime, latitude: latitude, longitude: longitude)
        userData.locationData.append(entry)
    }
}

extension UIViewController {
    /////////////////
    //             //
    //  SEND DATA  //
    //             //
    /////////////////
    
    func sendData(type: String) {
        ////////////////////////////////////////
        //                                    //
        //  IF NOT CONNECTED TO WIFI, RETURN  //
        //                                    //
        ////////////////////////////////////////
        let reachability = Reachability()!
        
        guard reachability.connection == .wifi else {
            //print("Not connected to wi-fi")
            return
        }
        
        ///////////////////////////////////////
        //                                   //
        //  IF CONNECTED TO WIFI, SEND DATA  //
        //                                   //
        ///////////////////////////////////////
        let userData = UserData.shared
        var urlString: String?
        var json: Data?
        let environment = Environment.shared
        
        switch type {
        case "health":
            if (userData.healthData.count) > 0 {
                urlString = environment.production.url + "insert-health-data.php"
                //urlString = environment.development.url + "insert-health-data.php"
                
                json = try? JSONEncoder().encode(userData.healthData)
            } else {
                //print("No health data to send")
                return
            }
        case "location":
            if (userData.locationData.count) > 0 {
                urlString = environment.production.url + "insert-location-data.php"
                //urlString = environment.development.url + "insert-location-data.php"
                
                json = try? JSONEncoder().encode(userData.locationData)
            } else {
                //print("No location data to send")
                return
            }
        case "survey":
            if (userData.surveyData.count) > 0 {
                urlString = environment.production.url + "insert-survey-data.php"
                //urlString = environment.development.url + "insert-survey-data.php"
                
                json = try? JSONEncoder().encode(userData.surveyData)
            } else {
                //print("No survey data to send")
                return
            }
        case "walkTest":
            if (userData.walkTestData.count) > 0 {
                urlString = environment.production.url + "insert-walk-test-data.php"
                //urlString = environment.development.url + "insert-walk-test-data.php"
                
                json = try? JSONEncoder().encode(userData.walkTestData)
            } else {
                //print("No walk test data to send")
                return
            }
        case "heightWeight":
            if (userData.heightWeightData.count) > 0 {
                urlString = environment.production.url + "insert-height-weight-data.php"
                //urlString = environment.development.url + "insert-height-weight-data.php"
                
                json = try? JSONEncoder().encode(userData.heightWeightData)
            } else {
                //print("No height and weight data to send")
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
        
        guard urlString != nil else {
            //print("urlString is nil")
            return
        }
        
        guard let url = URL(string: urlString!) else {
            //print("Could not generate URL from urlString")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard json != nil else {
            return
        }
        
        request.httpBody = json
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard (error == nil) else {
                //print("Error: \(error!.localizedDescription)")
                return
            }
                
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                    
                guard statusCode == 200 else {
                    //print("Error: status code is \(statusCode)")
                    return
                }
            }
                
            guard let data = data else {
                //print("Error: no data")
                return
            }
                
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    
                if (apiResponse.error) {
                    //print("Error: \(apiResponse.message)")
                    return
                } else {
                    //print("Success: \(apiResponse.message)")
                    
                    //////////////////////////////////////////////////////
                    //                                                  //
                    //  IF SUCCESSFUL, DELETE PREVIOUS DATA FROM PHONE  //
                    //                                                  //
                    //////////////////////////////////////////////////////
                        
                    DispatchQueue.main.async {
                        switch type {
                        case "health":
                            userData.healthData.removeAll()
                        case "location":
                            userData.locationData.removeAll()
                        case "survey":
                            userData.surveyData.removeAll()
                        case "walkTest":
                            userData.walkTestData.removeAll()
                        case "heightWeight":
                            userData.heightWeightData.removeAll()
                        default:
                            return
                        }
                    }
                }
            } catch {
                //print("Error: \(error.localizedDescription)")
                return
            }
        }).resume()
    }
}
