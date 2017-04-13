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
    
    var duration = 60 * 6 //6 minutes
    var previous_steps = 0
    var stationary_count = 0
    var audio_queue: [String] = [String]()
    
    //heading variables
    let headingThreshold = 15
    var startHeading = 0
    var startHeadingMin = 0
    var startHeadingMax = 0
    var returnHeading = 0
    var returnHeadingMin = 0
    var returnHeadingMax = 0
    var laps = 0
    
    var taskID: UIBackgroundTaskIdentifier!
    
    let time_label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = "06:00"
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
        UIApplication.shared.endBackgroundTask(taskID)
        stop()
        reset()
        locationManager.stopUpdatingHeading()
        pedometerManager.stopUpdates()
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
    
    func reset() {
        pedometerManager.reset()
        self.laps = 0
    }
    
    //////////////////////////
    //                      //
    //  6 MINUTE WALK TEST  //
    //                      //
    //////////////////////////
    override func viewDidAppear(_ animated: Bool) {
        //Start background task
        taskID = UIApplication.shared.beginBackgroundTask(expirationHandler: {})
        
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
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(intro_pt2_countdown), userInfo: nil, repeats: true)
            return
        }
    }
    
    /* [3] wait for 3 seconds, start pedometer updates, start 6 minute countdown */
    func intro_pt2_countdown() {

        //we're not waiting for audio to stop playing as the audio runs for a little longer than 3 seconds. We want to start the countdown as soon as the patient hears the word "Go".
        timer.invalidate()
        setupHeadings()
        pedometerManager.startUpdates()
            
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    /* [4] 6 minute countdown */
    func countdown() {
        //prints the amount of time the app has to run in the background, it seems to count down from 180. Though, when audio is played, it seems to bring the app into the foreground (signified by the large time remaining). When the audio stops playing, the background timer begins counting down from 180 again.
        print(UIApplication.shared.backgroundTimeRemaining)
        
        duration = duration - 1
        
        let (m, s) = secondsToMinutesSeconds(seconds: duration)
        time_label.text = "\(formatTime(time: m)):\(formatTime(time: s))"
        //steps_label.text = "steps: \(pedometerManager.steps)"
        //distance_label.text = "distance: \(pedometerManager.distance)"
        
        if let currentHeading = locationManager.currentHeading {
            if (laps%2 == 0) {
                if (Int(currentHeading) > returnHeadingMin && Int(currentHeading) < returnHeadingMax) {
                    laps += 1
                    //lapsLabel.text = "laps: \(laps)"
                }
            } else if (laps%2 == 1) {
                if (Int(currentHeading) > startHeadingMin && Int(currentHeading) < startHeadingMax) {
                    laps += 1
                    //lapsLabel.text = "laps: \(laps)"
                }
            }
        }
        
        guard duration > 15 else {
            /* if time == 15, start 15 second countdown */
            if (duration == 15) {
                if (audioManager.isPlaying()) {
                    audioManager.stopAudio()
                }
                audioManager.playAudio(name: "fifteen-sec-countdown")
            }

            /* if time == 0, stop updating heading, start conclusion pt 1 */
            if (duration == 0) {
                stop()
                locationManager.stopUpdatingHeading()
            
                audioManager.playAudio(name: "conclusion-pt1")
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(conclusion_pt1_countdown), userInfo: nil, repeats: true)
            }
            return
        }
        
        if (duration%60 == 0) {
            if (duration == 60 * 5) {
                audio_queue.append("time-remaining-pt1")
                addEncouragement()
            } else if (duration == 60 * 4) {
                audio_queue.append("time-remaining-pt2")
                addEncouragement()
            } else if (duration == 60 * 3) {
                audio_queue.append("time-remaining-pt3")
                addEncouragement()
            } else if (duration == 60 * 2) {
                audio_queue.append("time-remaining-pt4")
                addEncouragement()
            } else if (duration == 60 * 1) {
                audio_queue.append("time-remaining-pt5")
                addEncouragement()
            }
        /* play 1 of 8 encouragement audio every 30 seconds */
        } else if (duration%30 == 0) {
            addEncouragement()
        }
        
        /* if steps hasn't increased for 20 seconds, play stationary encouragement */
        if (pedometerManager.steps == previous_steps) {
            stationary_count = stationary_count + 1
            
            if (stationary_count == 20) {
                audio_queue.append("stationary-encouragement")
                stationary_count = 0
            }
        } else {
            stationary_count = 0
            previous_steps = pedometerManager.steps
        }
        
        if (audio_queue.count > 0) {
            if (!audioManager.isPlaying()) {
                if let audio = audio_queue.first {
                    audioManager.playAudio(name: audio)
                    audio_queue.removeFirst()
                }
            }
        }
    }
    
    /* encouragement will not play if other audio is playing */
    func addEncouragement() {
        let random_number = arc4random_uniform(8) + 1;
        
        switch random_number {
        case 1:
            audio_queue.append("encouragement-pt1")
        case 2:
            audio_queue.append("encouragement-pt2")
        case 3:
            audio_queue.append("encouragement-pt3")
        case 4:
            audio_queue.append("encouragement-pt4")
        case 5:
            audio_queue.append("encouragement-pt5")
        case 6:
            audio_queue.append("encouragement-pt6")
        case 7:
            audio_queue.append("encouragement-pt7")
        case 8:
            audio_queue.append("encouragement-pt8")
        default:
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
        
        //steps_label.text = "steps: \(pedometerManager.steps)"
        //distance_label.text = "distance: \(pedometerManager.distance)"
        
        let unique_id = UserDefaults.standard.object(forKey: "unique_id") as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dateFormatter.string(from: Date())
        
        let data_to_send = DataToSend.sharedInstance
        data_to_send.walk_test_data["walk_test_data"]?.append(["unique_id":unique_id!, "time":time, "steps":String(pedometerManager.steps), "distance":String(pedometerManager.distance), "laps":String(self.laps)])
        
        audioManager.playAudio(name: "conclusion-pt2")
        reset()
        
        UIApplication.shared.endBackgroundTask(taskID)
        
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
    
    func setupHeadings() {
        guard let currentHeading = locationManager.currentHeading else {
            return
        }
        startHeading = Int(currentHeading)
        
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
    
    ////////////////////////////
    //                        //
    //  FOR TESTING PURPOSES  //
    //                        //
    ////////////////////////////
    
    /*
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
    
    let lapsLabel: UILabel = {
        let label = UILabel()
        label.text = "laps: 0"
        return label
    }()
 */
    
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
        /*
        view.addSubview(steps_label)
        view.addSubview(distance_label)
        view.addSubview(lapsLabel)
        
        steps_label.translatesAutoresizingMaskIntoConstraints = false
        steps_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        steps_label.topAnchor.constraint(equalTo: time_label.bottomAnchor, constant: 5).isActive = true
        
        distance_label.translatesAutoresizingMaskIntoConstraints = false
        distance_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        distance_label.topAnchor.constraint(equalTo: steps_label.bottomAnchor, constant: 5).isActive = true
        
        lapsLabel.translatesAutoresizingMaskIntoConstraints = false
        lapsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lapsLabel.topAnchor.constraint(equalTo: distance_label.bottomAnchor, constant: 5).isActive = true
 */
    }
}
