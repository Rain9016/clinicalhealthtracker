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
import AVFoundation

class SixMinuteWalkTestController: UIViewController, CLLocationManagerDelegate {
    //To use the iphone's pedometer, you must edit the Info.plist file, and add "Privacy - Motion Usage Description" as a key, String as a type, and the message you want to show your user as a value.
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    var locationManager: CLLocationManager!
    
    var hasStarted = false
    var steps = 0
    var laps = 0
    var distance = 0
    
    //heading variables
    let headingThreshold = 10
    var startHeading = 0
    var startHeadingMin = 0
    var startHeadingMax = 0
    var returnHeading = 0
    var returnHeadingMin = 0
    var returnHeadingMax = 0
    var currentHeading = 0
    
    //timer variables
    var timeRemainingWalkTest = 30 //time limit for the walk test (6 minutes)
    var timeRemainingAudio = 13 //time remaining for the first audio clip
    var timer = Timer()
    
    //audio variables
    var audioPlayer = AVAudioPlayer()
    var audioPath = ""
    
    ///////////////////////
    //                   //
    //  RESET VARIABLES  //
    //                   //
    ///////////////////////
    
    func reset() {
        timeRemainingWalkTest = 30
        timeRemainingAudio = 13
        hasStarted = false
        steps = 0
        laps = 0
        distance = 0
        
        setTimeRemainingLabel(timeRemaining: timeRemainingWalkTest)
        setStepsLabel(numberOfSteps: steps)
        setLapsLabel(numberOfLaps: laps)
        setDistanceLabel(distanceWalked: distance)
        
        startButton.isEnabled = true
        startButton.alpha = 1
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
    }
    
    ////////////////////////////
    //                        //
    //  TIME REMAINING LABEL  //
    //                        //
    ////////////////////////////
    
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
        self.timeRemainingWalkTest = timeRemaining
        let (m, s) = secondsToMinutesSeconds(seconds: timeRemaining)
        timeRemainingLabel.text = "\(timeText(m)):\(timeText(s))"
    }
    
    ////////////////////////////////////
    //                                //
    //  STEPS, LAPS, DISTANCE LABELS  //
    //                                //
    ////////////////////////////////////
    
    /* STEPS */
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
    
    /* LAPS */
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
    
    func setLapsLabel(numberOfLaps: Int) {
        lapsLabel.text = "Laps: \(numberOfLaps)"
    }
    
    /* DISTANCE */
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
    
    func setDistanceLabel(distanceWalked: Int) {
        distanceLabel.text = "Distance: \(distanceWalked)"
    }
    
    //////////////////////////////
    //                          //
    //  START AND STOP BUTTONS  //
    //                          //
    //////////////////////////////
    
    /* START BUTTON */
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
        locationManager.startUpdatingHeading()
        
        playAudio(name: "6MWT-intro")
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getCurrentHeading), userInfo: nil, repeats: true)
        
        startButton.isEnabled = false
        startButton.alpha = 0.5
        stopButton.isEnabled = true
        stopButton.alpha = 1
    }
    
    /* STOP BUTTON */
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
        if (audioPlayer.isPlaying) {
            audioPlayer.stop()
        }
        
        timer.invalidate()
        pedometer.stopUpdates()
        locationManager.stopUpdatingHeading()
        reset()
    }
    
    ///////////////////////////////////
    //                               //
    //  WALK TEST FUNCTIONS RELATED  //
    //                               //
    ///////////////////////////////////
    
    /* BEFORE WALK TEST BEGINS */
    func getCurrentHeading() {
        timeRemainingAudio = timeRemainingAudio - 1
        
        if (timeRemainingAudio == 0) {
            timer.invalidate() //invalidate old timer
            
            setupHeadings()
            hasStarted = true
            
            playAudio(name: "6MWT-countdown-start")
            
            //start new timer
            timeRemainingAudio = 3
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beginCountdown), userInfo: nil, repeats: true)
        }
    }
    
    func beginCountdown() {
        timeRemainingAudio = timeRemainingAudio - 1
        
        if (timeRemainingAudio == 0) {
            timer.invalidate() //invalidate old timer
            
            //begin counting steps
            let currentTime = getCurrentLocalDate()
            countSteps(from: currentTime)
            
            //start new timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        }
    }
    
    /* WHILE WALK TEST IS IN PROGRESS */
    func countdown() {
        timeRemainingWalkTest = timeRemainingWalkTest - 1 //reduce time
        
        //display the amount of time left
        let (m, s) = secondsToMinutesSeconds(seconds: timeRemainingWalkTest)
        timeRemainingLabel.text = "\(timeText(m)):\(timeText(s))"
        
        //increment the number of laps if needed
        if (laps%2 == 0) {
            if (currentHeading > returnHeadingMin && currentHeading < returnHeadingMax) {
                laps += 1
                lapsLabel.text = "Laps: \(laps)"
            }
        } else if (laps%2 == 1) {
            if (currentHeading > startHeadingMin && currentHeading < startHeadingMax) {
                laps += 1
                lapsLabel.text = "Laps: \(laps)"
            }
        }
        
        if (timeRemainingWalkTest == 5) {
            playAudio(name: "6MWT-countdown-end")
        }
        
        if (timeRemainingWalkTest == 0) {
            timer.invalidate()
            stopButton.isEnabled = false
            stopButton.alpha = 0.5
            
            playAudio(name: "6MWT-congratulations")
            
            //finalise results
            timeRemainingAudio = 10
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(finaliseResults), userInfo: nil, repeats: true)
        }
    }
    
    /* ONCE WALK TEST HAS FINISHED */
    func finaliseResults() {
        timeRemainingAudio = timeRemainingAudio - 1
        
        if (timeRemainingAudio == 0) {
            timer.invalidate()
            pedometer.stopUpdates()
            locationManager.stopUpdatingHeading()
            
            playAudio(name: "6MWT-results-finalised")
            
            timeRemainingAudio = 5
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(resultsFinalised), userInfo: nil, repeats: true)
        }
    }
    
    func resultsFinalised() {
        timeRemainingAudio = timeRemainingAudio - 1
        
        if (timeRemainingAudio == 0) {
            timer.invalidate()
            //reset()
            
            stopButton.isEnabled = true
            stopButton.alpha = 1
            
            //segue to results finalised page
        }
    }

    
    //////////////////////////////////
    //                              //
    //  LOCATION RELATED FUNCTIONS  //
    //                              //
    //////////////////////////////////
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
    }
    
    func setupHeadings() {
        startHeading = currentHeading
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
        
        returnHeadingMin = returnHeading - headingThreshold
        
        if (returnHeadingMin < 0) {
            returnHeadingMin += 360
        }
        
        returnHeadingMax = returnHeading + headingThreshold
        
        if (returnHeadingMax > 360) {
            returnHeadingMax -= 360
        }
    }
    
    /* every time the heading is updated */
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        currentHeading = Int(newHeading.magneticHeading)
    }
    
    ///////////////////////////////////
    //                               //
    //  PEDOMETER RELATED FUNCTIONS  //
    //                               //
    ///////////////////////////////////
    
    func countSteps(from: Date) {
        if(CMPedometer.isStepCountingAvailable()){
            pedometer.startUpdates(from: from) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        /* get steps */
                        self.steps = Int(data!.numberOfSteps)
                        self.setStepsLabel(numberOfSteps: Int(data!.numberOfSteps))
                        
                        /* get distance */
                        self.distance = Int(data!.distance!)
                        self.setDistanceLabel(distanceWalked: Int(data!.distance!))
                    } else {
                        //handle error
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
    
    /* This function converts seconds to minutes and seconds and stores the result in a tuple */
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    /* This function takes a number of seconds, and returns a string representing that number of seconds in minutes and seconds in the format of mm:ss */
    func timeText(_ s: Int) -> String {
        return s < 10 ? "0\(s)" : "\(s)"
    }
    
    ///////////////////////////////
    //                           //
    //  AUDIO RELATED FUNCTIONS  //
    //                           //
    ///////////////////////////////
    
    /* This function plays an audio clip */
    func playAudio(name: String) {
        do {
            let audioPath = Bundle.main.path(forResource: name, ofType: "mp3")
            
            audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
        } catch {
            print("error playing audio")
        }
        
        audioPlayer.play()
    }
    
    ////////////////////
    //                //
    //  MAIN PROGRAM  //
    //                //
    ////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set walk test variables
        reset()
        
        //setup location manager
        setupLocationManager()
        
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
