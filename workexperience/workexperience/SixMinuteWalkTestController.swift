//
//  SixMinuteWalkTestController.swift
//  workexperience
//
//  Created by untitled on 5/12/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class SixMinuteWalkTestController: UIViewController, CLLocationManagerDelegate {
    //To use the iphone's pedometer, you must edit the Info.plist file, and add "Privacy - Motion Usage Description" as a key, String as a type, and the message you want to show your user as a value.
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    var locationManager: CLLocationManager!
    
    var hasStarted = false
    
    //start heading variables
    let headingThreshold = 10
    var startHeading = 0
    var startHeadingMin = 0
    var startHeadingMax = 0
    var returnHeading = 0
    var returnHeadingMin = 0
    var returnHeadingMax = 0
    var currentHeading = 0
    //end heading variables.
    
    var timeRemaining = 0
    var timer = Timer()
    var timerTwo = Timer()
    var steps = 0
    var laps = 0
    var distance = 0
    
    var timeRemainingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 90)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupTimeRemainingLabel() {
        timeRemainingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeRemainingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
    }
    
    func setTimeRemainingLabel(timeRemaining: Int) {
        self.timeRemaining = timeRemaining
        let (m, s) = secondsToMinutesSeconds(seconds: timeRemaining)
        timeRemainingLabel.text = "\(timeText(m)):\(timeText(s))"
    }
    
    ////////////////////////////////////
    //                                //
    //  STEPS, LAPS, DISTANCE LABELS  //
    //                                //
    ////////////////////////////////////
    
    var stepsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupStepsLabel() {
        stepsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        stepsLabel.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func setStepsLabel(numberOfSteps: Int) {
        stepsLabel.text = "Steps: \(numberOfSteps)"
    }
    
    var lapsLabel: UILabel = {
        let label = UILabel()
        label.text = "Laps: 0"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupLapsLabel() {
        lapsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        lapsLabel.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor).isActive = true
    }
    
    var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Distance: 0"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupDistanceLabel() {
        distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: lapsLabel.bottomAnchor).isActive = true
    }
    
    //////////////////////////////
    //                          //
    //  START AND STOP BUTTONS  //
    //                          //
    //////////////////////////////
    
    var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupStartButton() {
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 20).isActive = true
        //startButton.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 20).isActive = true
        
        startButton.addTarget(self, action: #selector(handleStart), for: UIControlEvents.touchUpInside)
    }
    
    func handleStart() {
        setupHeadings()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        let currentTime = getCurrentLocalDate()
        countSteps(time: currentTime)
        
        startButton.isEnabled = false
        startButton.alpha = 0.5
        stopButton.isEnabled = true
        stopButton.alpha = 1
    }
    
    var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    func setupStopButton() {
        stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor).isActive = true
        
        stopButton.addTarget(self, action: #selector(handleStop), for: UIControlEvents.touchUpInside)
    }
    
    func handleStop() {
        pedometer.stopUpdates()
        timer.invalidate()
        locationManager.stopUpdatingHeading()
        reset()
        
        startButton.isEnabled = true
        startButton.alpha = 1
    }
    
    func reset() {
        setTimeRemainingLabel(timeRemaining: 30)
        setStepsLabel(numberOfSteps: 0)
        
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
    }
    
    //////////////////////////////////
    //                              //
    //  LOCATION RELATED FUNCTIONS  //
    //                              //
    //////////////////////////////////
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //locationManager.startUpdatingHeading()
        //locationManager.requestWhenInUseAuthorization()
    }
    
    func setupHeadings() {
        startHeading = currentHeading
        //startHeadingLabel.text = "Start heading: \(startHeading)"
        startHeadingMin = startHeading - headingThreshold
        
        if (startHeadingMin < 0) {
            startHeadingMin += 360
        }
        
        startHeadingMax = startHeading + headingThreshold
        
        if (startHeadingMax > 360) {
            startHeadingMax -= 360
        }
        
        returnHeading = startHeading - 180
        
        if (returnHeading < 0) {
            returnHeading += 360
        } else if (returnHeading > 360) {
            returnHeading -= 360
        }
        
        //returnHeadingLabel.text = "Return heading: \(returnHeading)"
        
        returnHeadingMin = returnHeading - headingThreshold
        
        if (returnHeadingMin < 0) {
            returnHeadingMin += 360
        }
        
        returnHeadingMax = returnHeading + headingThreshold
        
        if (returnHeadingMax > 360) {
            returnHeadingMax -= 360
        }
        
        hasStarted = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        currentHeading = Int(newHeading.magneticHeading)
        //currentHeadingLabel.text = "Current heading: \(currentHeading)"
        print(currentHeading)
    }
    
    ///////////////////////////////////
    //                               //
    //  PEDOMETER RELATED FUNCTIONS  //
    //                               //
    ///////////////////////////////////
    
    func countSteps(time: Date) {
        if(CMPedometer.isStepCountingAvailable()){
            pedometer.startUpdates(from: time) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        print("\(data!.numberOfSteps)")
                        self.steps = Int(data!.numberOfSteps)
                        self.setStepsLabel(numberOfSteps: Int(data!.numberOfSteps))
                    } else {
                        //could not start counting steps
                    }
                })
            }
        }
    }
    
    ///////////////////////////////
    //                           //
    //  TIMER RELATED FUNCTIONS  //
    //                           //
    ///////////////////////////////
    
    func getCurrentLocalDate() -> Date {
        let date = Date()
        //let calendar = Calendar.current
        
        //let hour = calendar.component(.hour, from: date)
        //let minute = calendar.component(.minute, from: date)
        //let second = calendar.component(.second, from: date)
        
        return date
    }
    
    func countdown() {
        timeRemaining = timeRemaining - 1
        let (m, s) = secondsToMinutesSeconds(seconds: timeRemaining)
        timeRemainingLabel.text = "\(timeText(m)):\(timeText(s))"
        
        print("current heading is: \(currentHeading)")
        print("startHeading is: \(startHeading)")
        print("startHeadingMin is: \(startHeadingMin)")
        print("startHeadingMax is: \(startHeadingMax)")
        print("returnHeading is: \(returnHeading)")
        print("returnHeadingMin is: \(returnHeadingMin)")
        print("returnHeadingMax is: \(returnHeadingMax)")
        
        if (laps%2 == 0) {
            if (currentHeading > returnHeadingMin && currentHeading < returnHeadingMax) {
                laps += 1
                lapsLabel.text = "Number of laps: \(laps)"
            }
        } else if (laps%2 == 1) {
            if (currentHeading > startHeadingMin && currentHeading < startHeadingMax) {
                laps += 1
                lapsLabel.text = "Number of laps: \(laps)"
            }
        }
        
        if (timeRemaining == 0) {
            pedometer.stopUpdates()
            timer.invalidate()
        }
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func timeText(_ s: Int) -> String {
        return s < 10 ? "0\(s)" : "\(s)"
    }
    
    
    ////////////////////
    //                //
    //  MAIN PROGRAM  //
    //                //
    ////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup location manager
        setupLocationManager()
        locationManager.startUpdatingHeading()
        
        //initialise timer (seconds)
        reset()
        
        //setup table view
        navigationItem.title = "6MWT"
        //view.delaysContentTouches = false //this enables button animations, I don't know why.
        
        view.backgroundColor = UIColor.white
        
        //setup views
        view.addSubview(timeRemainingLabel)
        setupTimeRemainingLabel()
        view.addSubview(stepsLabel)
        setupStepsLabel()
        view.addSubview(lapsLabel)
        setupLapsLabel()
        view.addSubview(distanceLabel)
        setupDistanceLabel()
        view.addSubview(startButton)
        setupStartButton()
        view.addSubview(stopButton)
        setupStopButton()
    }
}
