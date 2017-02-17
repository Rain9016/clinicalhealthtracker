//
//  WalkTestController.swift
//  healthtracker
//
//  Created by untitled on 16/2/17.
//
//

import UIKit

class WalkTestController: UIViewController {
    let locationManager = LocationManager.sharedInstance
    let pedometerManager = PedometerManager.sharedInstance
    let audioManager = AudioManager.sharedInstance
    var timer = Timer()
    
    var duration = 30 * 1 //6 minutes
    var initial_countdown = 3
    
    var threshold = 10
    var forward_heading = 0
    var backward_heading = 0
    
    let time_label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = "00:30"
        return label
    }()
    
    let cancel_button: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Cancel"
        barButtonItem.style = .done
        barButtonItem.action = #selector(cancelButtonAction)
        return barButtonItem
    }()
    
    func cancelButtonAction() {
        stop()
        dismiss(animated: true, completion: nil)
    }
    
    func stop() {
        if (audioManager.isPlaying()) {
            audioManager.stopAudio()
        }
        
        if (timer.isValid) {
            timer.invalidate()
        }
    }
    
    //////////////////////////
    //                      //
    //  6 MINUTE WALK TEST  //
    //                      //
    //////////////////////////
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingHeading()
        
        /* [1] start introduction */
        audioManager.playAudio(name: "intro-pt1")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(intro_pt1_countdown), userInfo: nil, repeats: true)
    }
    
    /* [2] wait for introduction to finish, start 3 second countdown */
    func intro_pt1_countdown() {
        guard audioManager.isPlaying() else {
            timer.invalidate()
            
            audioManager.playAudio(name: "intro-pt2")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(intro_pt2_countdown), userInfo: nil, repeats: true)
            return
        }
    }
    
    /* [3] wait for 3 seconds, start pedometer updates, start 6 minute countdown */
    func intro_pt2_countdown() {
        initial_countdown = initial_countdown - 1 //we're not waiting for audio to stop playing as the audio runs for a little longer than 3 seconds. We want to start the countdown as soon as the patient hears the word "Go".
        
        if (initial_countdown == 0) {
            timer.invalidate()
            pedometerManager.startUpdates()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
            return
        }
    }
    
    /* [4] 6 minute countdown */
    func countdown() {
        duration = duration - 1
        let (m, s) = secondsToMinutesSeconds(seconds: duration)
        time_label.text = "\(formatTime(time: m)):\(formatTime(time: s))"
        steps_label.text = "steps: \(pedometerManager.steps)"
        distance_label.text = "distance: \(pedometerManager.distance)"
        
        /* if time == 0, stop updating heading, start conclusion pt 1 */
        if (duration == 0) {
            stop()
            locationManager.stopUpdatingHeading()
            
            audioManager.playAudio(name: "conclusion-pt1")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(conclusion_pt1_countdown), userInfo: nil, repeats: true)
            return
        }
        
        /* if time == 15, start 15 second countdown */
        if (duration == 15) {
            if (audioManager.isPlaying()) {
                audioManager.stopAudio()
            }
            audioManager.playAudio(name: "fifteen-sec-countdown")
            return
        }
        
        if (duration%60 == 0) {
            if (duration == 60 * 5) {
                if (audioManager.isPlaying()) {
                    audioManager.stopAudio()
                }
                audioManager.playAudio(name: "countdown-pt1")
            } else if (duration == 60 * 4) {
                if (audioManager.isPlaying()) {
                    audioManager.stopAudio()
                }
                audioManager.playAudio(name: "countdown-pt2")
            } else if (duration == 60 * 3) {
                if (audioManager.isPlaying()) {
                    audioManager.stopAudio()
                }
                audioManager.playAudio(name: "countdown-pt3")
            } else if (duration == 60 * 2) {
                if (audioManager.isPlaying()) {
                    audioManager.stopAudio()
                }
                audioManager.playAudio(name: "countdown-pt4")
            } else if (duration == 60 * 1) {
                if (audioManager.isPlaying()) {
                    audioManager.stopAudio()
                }
                audioManager.playAudio(name: "countdown-pt5")
            }
            return
        /* play 1 of 8 encouragement audio every 15 seconds */
        } else if (duration%15 == 0) {
            if (audioManager.isPlaying()) {
                audioManager.stopAudio()
            }
            
            let random_number = arc4random_uniform(8) + 1;
            
            switch random_number {
            case 1:
                audioManager.playAudio(name: "encouragement-pt1")
            case 2:
                audioManager.playAudio(name: "encouragement-pt2")
            case 3:
                audioManager.playAudio(name: "encouragement-pt3")
            case 4:
                audioManager.playAudio(name: "encouragement-pt4")
            case 5:
                audioManager.playAudio(name: "encouragement-pt5")
            case 6:
                audioManager.playAudio(name: "encouragement-pt6")
            case 7:
                audioManager.playAudio(name: "encouragement-pt7")
            case 8:
                audioManager.playAudio(name: "encouragement-pt8")
            default:
                return
            }
            return
        }
    }
    
    /* [5] wait for conclusion pt 1 to finish, start final 3 second countdown */
    func conclusion_pt1_countdown() {
        guard audioManager.isPlaying() else {
            timer.invalidate()
            
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(final_countdown), userInfo: nil, repeats: true)
            return
        }
    }
    
    /* [6] after 3 seconds has elapsed, stop pedometer, present activity complete controller */
    func final_countdown() {
        timer.invalidate()
        pedometerManager.stopUpdates()
        
        steps_label.text = "steps: \(pedometerManager.steps)"
        distance_label.text = "distance: \(pedometerManager.distance)"
        
        audioManager.playAudio(name: "conclusion-pt2")
        
        //STORE STEPS AND DISTANCE
        
        pedometerManager.steps = 0
        pedometerManager.distance = 0
        
        let activityCompleteController = ActivityCompleteController()
        activityCompleteController.activity = "walk_test"
        self.navigationController?.pushViewController(activityCompleteController, animated: true)
    }
    
    //////////////
    //          //
    //  IMAGES  //
    //          //
    //////////////
    let stopwatch_image: UIImageView = {
        let label = UILabel()
        label.font = UIFont.init(name: "Ionicons", size: 500)
        label.textColor = UIColor(r: 204, g: 0, b: 0)
        label.alpha = 0.05
        label.text = "\u{f4b4}"
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        let image = UIImage.imageWithLabel(label: label)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let walking_image: UIImageView = {
        let label = UILabel()
        label.font = UIFont.init(name: "Ionicons", size: 300)
        label.textColor = UIColor(r: 204, g: 0, b: 0)
        label.text = "\u{f3bb}"
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        let image = UIImage.imageWithLabel(label: label)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    ///////////////////////
    //                   //
    //  MISC. FUNCTIONS  //
    //                   //
    ///////////////////////
    
    /* Converts seconds to minutes and seconds, stores the result in a tuple */
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    /* Turns minutes or seconds into mm or ss format */
    func formatTime(time: Int) -> String {
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    ////////////////////////////
    //                        //
    //  FOR TESTING PURPOSES  //
    //                        //
    ////////////////////////////
    
    let steps_label: UILabel = {
        let label = UILabel()
        label.text = "steps: 0"
        return label
    }()
    
    let distance_label: UILabel = {
        let label = UILabel()
        label.text = "distance: 0"
        return label
    }()
    
    /////////////////////
    //                 //
    //  VIEW DID LOAD  //
    //                 //
    /////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Walk Test"
        
        self.navigationController?.navigationBar.tintColor = UIColor.init(r: 204, g: 0, b: 0)
        cancel_button.target = self
        self.navigationItem.rightBarButtonItem = cancel_button
        
        let offset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 20
        view.addSubview(time_label)
        time_label.translatesAutoresizingMaskIntoConstraints = false
        time_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        time_label.topAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
        
        view.addSubview(stopwatch_image)
        stopwatch_image.translatesAutoresizingMaskIntoConstraints = false
        stopwatch_image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stopwatch_image.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 75).isActive = true //location services
        
        view.addSubview(walking_image)
        walking_image.translatesAutoresizingMaskIntoConstraints = false
        walking_image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        walking_image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        /* for testing purposes */
        view.addSubview(steps_label)
        view.addSubview(distance_label)
        
        steps_label.translatesAutoresizingMaskIntoConstraints = false
        steps_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        steps_label.topAnchor.constraint(equalTo: time_label.bottomAnchor, constant: 5).isActive = true
        
        distance_label.translatesAutoresizingMaskIntoConstraints = false
        distance_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        distance_label.topAnchor.constraint(equalTo: steps_label.bottomAnchor, constant: 5).isActive = true
    }
}
